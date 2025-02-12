Return-Path: <stable+bounces-115032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B73A321EC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E931164A38
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3029205E18;
	Wed, 12 Feb 2025 09:19:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A8205ADD;
	Wed, 12 Feb 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351981; cv=none; b=Bm0lvGvPfpYF+EdJSdFCdNWMvbbYpPxAPUVJnPlLdA3MuzVH74wZZyqSOuoTHS7GscnyBeX9FqTmoampRU3ElHtneLKwxtpir6Y/x8mWB/6wO7bCn2EcS8x85M4VHewUFE9dRAgNOX83ClV4uJyoK3Z06zFUK4suZ0bTcTqlCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351981; c=relaxed/simple;
	bh=2IQGUnrfpIddw8m2be7/PbtVzTD7MU+eoP3y4GoMQmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZinIqQ5a8zTGZpM6OClRnt6FiYyH5Q41Ux7uRLrQT2ny++UhoCdqIqX/7KzudkVszaDKmfS6pB/ChI75kbHjrlgzz0b7EkffM3tCUMaLUNvw1fW44VNc2c6fYJ6lYkXi1Ytoq/PvFB+C8zYiqaw7phvq2KVfF4dpLi2mS3sbiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowACXkziTZ6xnDxaiDA--.30403S2;
	Wed, 12 Feb 2025 17:19:17 +0800 (CST)
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
Subject: [PATCH] net: microchip: sparx5: Fix potential NULL pointer dereference in debugfs
Date: Wed, 12 Feb 2025 17:18:46 +0800
Message-ID: <20250212091846.1166-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXkziTZ6xnDxaiDA--.30403S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWftrykur4rZFWkKw4fAFb_yoW8JFWDpa
	1DuFyYg3ykAwsxGw17Cw48XFyrWan0gFyfWrWruwn5ZFnYgFZ3Xr15CrWF9ryFqrZxGrnx
	tF45Za9IyF1qyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcLA2esWj42QgAAsY

In vcap_debugfs_show_rule_keyset(), the function vcap_keyfields()
returns a NULL pointer upon allocation failure. This can lead to
a NULL pointer dereference in vcap_debugfs_show_rule_keyfield().
To prevent this, add a check for a NULL return value from
vcap_keyfields() and continue the loop if it is NULL.

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


