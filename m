Return-Path: <stable+bounces-115059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF88A32841
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9053A5CF2
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626F20FA8F;
	Wed, 12 Feb 2025 14:19:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEE1A5AA;
	Wed, 12 Feb 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369956; cv=none; b=BZpJSeO0A+3zLNHS002kKx+xYGwh19YG/W+/JYWIeg7p4JVPQzrgR0U4Kgp5C+CYJuA1RxpZgxrFv3FRqaShHHsPIL3PX0KCS5d9uUp+2q2BRquJF6ety6Wrxbq617qjyDlQGPZ2vCoq5VwjcxHJB9xjaUK6QHWQR9owJVm7DMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369956; c=relaxed/simple;
	bh=hePOXBAyH+DtbFWymWK4E16ILxWpqBJfArdmWI3Upn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEdYn6KUX2jqD7IMGyWVtlalcq8GQOJsN2PEVYMPzKP46ulpKSjy24o6k0NIfWxrRIJHd1eYhdteCNI8TEpwSP8xYte+OsKub4z93blvk+udfzO2COZsz4MbRXBRWAIltpddYTN82y+x8SiHR3yEXsp9BkPtR4TTkHiDhe138CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAD3YMrEraxnexx3DA--.41351S2;
	Wed, 12 Feb 2025 22:18:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com
Cc: UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] net: microchip: sparx5: Fix potential NULL pointer dereference
Date: Wed, 12 Feb 2025 22:18:28 +0800
Message-ID: <20250212141829.1214-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3YMrEraxnexx3DA--.41351S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZw4rAF47Zw4xWw13KrWDtwb_yoW8Jr13pa
	1DuFy5Ww4kArsxG347Cw48Xry8Xan0gF93WrWrCwn5ZFnYqrZ3Xr1rCrWF9ryFqrZxGrnx
	tF4Yva9IyF1qyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoLA2espowP7AABsG

Check the return value of vcap_keyfields() in
vcap_debugfs_show_rule_keyset(). If vcap_keyfields()
returns NULL, skip the keyfield to prevent a NULL pointer
dereference when calling vcap_debugfs_show_rule_keyfield().

Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index 59bfbda29bb3..e9e2f7af9be3 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -202,6 +202,8 @@ static int vcap_debugfs_show_rule_keyset(struct vcap_rule_internal *ri,
 
 	list_for_each_entry(ckf, &ri->data.keyfields, ctrl.list) {
 		keyfield = vcap_keyfields(vctrl, admin->vtype, ri->data.keyset);
+		if (!keyfield)
+			continue;
 		vcap_debugfs_show_rule_keyfield(vctrl, out, ckf->ctrl.key,
 						keyfield, &ckf->data);
 	}
-- 
2.42.0.windows.2


