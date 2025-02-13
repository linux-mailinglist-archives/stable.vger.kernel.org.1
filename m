Return-Path: <stable+bounces-115104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415ECA33881
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B703B1670D0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF36207DFD;
	Thu, 13 Feb 2025 07:06:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71037205E06;
	Thu, 13 Feb 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430390; cv=none; b=NvDAovr5+JgyrWBjNmk4IXydVHyN1KE7eQTxhTxcGZS8YunMuujvrZ8nsEPzOFh4gKz7ft3+q+3OPWniI8DUxE+1rKtx1gi3EANLfe0E+pqCIrF381yDUtzrTQOrUfTzC72ZSTnGoNRMPVPuzeg0vgbMkkkCUl754SeRaS1ujqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430390; c=relaxed/simple;
	bh=9V8RYJrwxCeycj3We3K1dXBGOYEqueT+KippZbEYPqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4fiWfy427VonmGEhQfuZXuIW7DpmpnrdOhVFBLSd5tQaqeDCyOdzEHAEKPl47O8J1QeFQmNVw5ebGiVoIfmxVCi1t8kXYESsm3h8BJUb8AThvywfpMbt0nOGFXLLMYIGn9OoLwtfrd+DB+dzevWqgdrib3VK5vkWLeQUaQlgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADHzm7cma1njg7hDA--.25387S2;
	Thu, 13 Feb 2025 15:06:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	cezary.rojewski@intel.com,
	Julia.Lawall@inria.fr,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()
Date: Thu, 13 Feb 2025 15:05:46 +0800
Message-ID: <20250213070546.1572-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHzm7cma1njg7hDA--.25387S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4xCw1DuF48KFWftrWUArb_yoWfurX_XF
	18Xw1xWa4UAwnrKr43JrnYvFnag34xZF10grs2qF4UJ393Gr4Yqr45Kw1qkFykWa48GF13
	CrnrW3yq9ryxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8MA2etUhmyRAABs-

Check the return value of snd_ctl_rename_id() in
snd_hda_create_dig_out_ctls(). Ensure that potential
failures are properly handled.

Fixes: 5c219a340850 ("ALSA: hda: Fix kctl->id initialization")
Cc: stable@vger.kernel.org # 6.4+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/pci/hda/hda_codec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 14763c0f31ad..46a220404999 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2470,7 +2470,9 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 				break;
 			id = kctl->id;
 			id.index = spdif_index;
-			snd_ctl_rename_id(codec->card, &kctl->id, &id);
+			err = snd_ctl_rename_id(codec->card, &kctl->id, &id);
+			if (err < 0)
+				return err;
 		}
 		bus->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
 	}
-- 
2.42.0.windows.2


