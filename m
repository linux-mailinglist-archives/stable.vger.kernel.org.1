Return-Path: <stable+bounces-75648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D9973883
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBDB1F252AD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A281922F4;
	Tue, 10 Sep 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UdWazahL"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33D18D640;
	Tue, 10 Sep 2024 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974564; cv=none; b=HRn9WbdV6azFSq1G6zmPZGZiXNIWuszj/HijgTZqbBO+W3+4CYBeCnEfIN7eEgkvO+B1HzwHVa/faPrlHVGqdkBM27WDdzwHPfxdJOESiPJrTDPa8NuFfuHas77+obFNSz3UZJqOOP4B5iL4l9lTaDost09nh8kSJD8TgHRMj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974564; c=relaxed/simple;
	bh=lTnyoQDuv759vI/z0pNzng3k3Ma4g/Yf8S5lEgGDePU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DbZGU/X/t3ueFgUVaNKrbhMCcE83yVHKGY4+XfRm5NQ5atrKeICsTOSdzVVWe8Q68Y+st3qM/RoaJIN67cjG2odEVVE6L6UFl1Ghz3J+4MS8xBtYd1qBaBXNB6NPq7CD7NyLlTviOluk1W+cZjZTEXSdv3NT47WMU7jDWHaBAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UdWazahL; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.13])
	by mail.ispras.ru (Postfix) with ESMTPSA id 21D4D407616B;
	Tue, 10 Sep 2024 13:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 21D4D407616B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1725974125;
	bh=CDgc+4/+yTLA5VMZMTPWvHO3TmDO3b0Moiwhby7NsIo=;
	h=From:To:Cc:Subject:Date:From;
	b=UdWazahLN+THZdmKuFxLLtL/m97/YdD1RWdsaHDeslHWoJaqhEXdvRX+0fiOHSmzz
	 96u2XcYkx+JYq+9Omy7wcgI5uz7XGxLM7cV/TlHnoSOSBck659OKJVWcMW3pTElQmY
	 pb6wRoi++c2laLByuY/tfwK/A8ovVxIcihr7TLS8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10/5.15] Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()
Date: Tue, 10 Sep 2024 16:15:03 +0300
Message-Id: <20240910131503.146688-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

commit 815d5121927093017947fd76e627da03f0f70be7 upstream.

There is only one "goto done;" in set_device_flags() and this happens
*before* hci_dev_lock() is called, move the done label to after the
hci_dev_unlock() to fix the following unlock balance:

[   31.493567] =====================================
[   31.493571] WARNING: bad unlock balance detected!
[   31.493576] 5.17.0-rc2+ #13 Tainted: G         C  E
[   31.493581] -------------------------------------
[   31.493584] bluetoothd/685 is trying to release lock (&hdev->lock) at:
[   31.493594] [<ffffffffc07603f5>] set_device_flags+0x65/0x1f0 [bluetooth]
[   31.493684] but there are no more locks to release!

Note this bug has been around for a couple of years, but before
commit fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params flags")
supported_flags was hardcoded to "((1U << HCI_CONN_FLAG_MAX) - 1)" so
the check for unsupported flags which does the "goto done;" never
triggered.

Fixes: fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params flags")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
[fp: the check for unsupported flags can actually be triggered before
 commit fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params
 flags") by "Set Device Flags - Invalid Parameter 2" Bluez test as
 current_flags value comes from userspace]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0078e33e12ba..5d2289cf2bb1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4138,9 +4138,9 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		}
 	}
 
-done:
 	hci_dev_unlock(hdev);
 
+done:
 	if (status == MGMT_STATUS_SUCCESS)
 		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 				     supported_flags, current_flags);
-- 
2.39.2


