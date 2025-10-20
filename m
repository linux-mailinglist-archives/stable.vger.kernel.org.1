Return-Path: <stable+bounces-187930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D1BEF7A2
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F43B4BE2
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A12D837B;
	Mon, 20 Oct 2025 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ueHfJGWH"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610D2D8382;
	Mon, 20 Oct 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942010; cv=none; b=g5pGcA3Bytgr2pSudlsn4lKLneYEIRa+CeNaB4qxhnZycBxxdLMAyKXu3sn/e4ddWNXkiNnU3/XQnrsYvgwibxFiimyH7gtkjZyPN6QL7+NIZZreNNoeiPP0Rm0bMVBREw1h+OKYe7UxjSYOmzJQbPoPh97Kc9Opdkt0vcPu2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942010; c=relaxed/simple;
	bh=FEzwsFOvy/v03ZLbtJebqy/hxjdZUwkW0eHimLl/uoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkzKmTVkVjsOSZ/tdAdVkPkHZVj5oo/2wxlqrpEKjCkNWMnUjWuUk30OcVQrSlJwFT9GHVJSQbeVkdraIj2beqxLexvR5we0iL6EChkGtuPFXgDndWOXNVuRLO40m+cZkoIUuYUTC5ZBMWM96Ae+LB8YKIR1seuOPTwQE2dVb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=ueHfJGWH; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E04B8807EF;
	Mon, 20 Oct 2025 09:31:26 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:980::1:37])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MVO5mf3Ft8c0-jVpMFkLv;
	Mon, 20 Oct 2025 09:31:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1760941885;
	bh=nQTyHQD6nvJXJ6KJs/5NsdeNIuMnINOnwCKFZIX+qw8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ueHfJGWH4XWJPqU6rRlON860DNELB0YS/LlZaMALjNi0SaooMCjZb6k7XmoeZdEbY
	 N4Kr5A5W6miwSNB5E5NBvc0AlquMNyPBhu5ZQ8fdREhGtRTIJbglJ3RjALkyEG7vSg
	 mvND1cPmSy6kFhM6VreCjH1VRmUEo6cfuGJpmDJQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: lvc-patches@linuxtesting.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] comedi: Make insn_rw_emulate_bits() do insn->n samples
Date: Mon, 20 Oct 2025 09:31:22 +0300
Message-ID: <20251020063122.2007-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Abbott <abbotti@mev.co.uk>

commit 7afba9221f70d4cbce0f417c558879cba0eb5e66 upstream.

The `insn_rw_emulate_bits()` function is used as a default handler for
`INSN_READ` instructions for subdevices that have a handler for
`INSN_BITS` but not for `INSN_READ`.  Similarly, it is used as a default
handler for `INSN_WRITE` instructions for subdevices that have a handler
for `INSN_BITS` but not for `INSN_WRITE`. It works by emulating the
`INSN_READ` or `INSN_WRITE` instruction handling with a constructed
`INSN_BITS` instruction.  However, `INSN_READ` and `INSN_WRITE`
instructions are supposed to be able read or write multiple samples,
indicated by the `insn->n` value, but `insn_rw_emulate_bits()` currently
only handles a single sample.  For `INSN_READ`, the comedi core will
copy `insn->n` samples back to user-space.  (That triggered KASAN
kernel-infoleak errors when `insn->n` was greater than 1, but that is
being fixed more generally elsewhere in the comedi core.)

Make `insn_rw_emulate_bits()` either handle `insn->n` samples, or return
an error, to conform to the general expectation for `INSN_READ` and
`INSN_WRITE` handlers.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Cc: stable <stable@kernel.org> # 5.13+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250725141034.87297-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Andrey Troshin: backport fix from drivers/comedi/drivers.c to drivers/staging/comedi/drivers.c.]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2025-39686
Link: https://nvd.nist.gov/vuln/detail/CVE-2025-39686
---
 drivers/staging/comedi/drivers.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index fd098e62a308..816225d1e1a4 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -620,11 +620,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int chan = CR_CHAN(insn->chanspec);
 	unsigned int base_chan = (chan < 32) ? 0 : chan;
 	unsigned int _data[2];
+	unsigned int i;
 	int ret;
 
-	if (insn->n == 0)
-		return 0;
-
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
@@ -635,18 +633,21 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1U << (chan - base_chan);		     /* mask */
-		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		/* mask */
 	}
+	for (i = 0; i < insn->n; i++) {
+		if (insn->insn == INSN_WRITE)
+			_data[1] = data[i] ? _data[0] : 0;	/* bits */
 
-	ret = s->insn_bits(dev, s, &_insn, _data);
-	if (ret < 0)
-		return ret;
+		ret = s->insn_bits(dev, s, &_insn, _data);
+		if (ret < 0)
+			return ret;
 
-	if (insn->insn == INSN_READ)
-		data[0] = (_data[1] >> (chan - base_chan)) & 1;
+		if (insn->insn == INSN_READ)
+			data[i] = (_data[1] >> (chan - base_chan)) & 1;
+	}
 
-	return 1;
+	return insn->n;
 }
 
 static int __comedi_device_postconfig_async(struct comedi_device *dev,
-- 
2.34.1


