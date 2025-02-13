Return-Path: <stable+bounces-115108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2941A33921
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B33188A117
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F4320B209;
	Thu, 13 Feb 2025 07:46:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310B13CF9C;
	Thu, 13 Feb 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432778; cv=none; b=HvspYv14SvmMl06ec8uKAx0dV59afsXmYjluHAxWETTC5NozDboG5P5cbqwYJqOuNrQEcLx5AZjTCFzaUwfO9XI828FhyxN++wxKQ5xfZ6Ha2FdH7K86XCxO309He+lVSWcxLnNwpQhlTMBXGnwemA40Cs97LyaXGYWBM4l1ul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432778; c=relaxed/simple;
	bh=ZEB+/Qwgtx3GsqdRg27UH3TiVHs76hawzz/h1eaSTp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYxQ0UOJqOMKaliflRocvMcT9XWqeC8wQoT5fhUOH6wibNJXN/uVW+RAfI51rqFSGvf2281G1QZSGbE/6M674HWlPXIK/G8pHXuSz2KlqbG0sNkcFwfnlI5pu3PXs4lc6C4kNRdCpkQy3dfR9loKSldFVKvEVsu6SWU2uOcHe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowACnr287o61n96ziDA--.2695S2;
	Thu, 13 Feb 2025 15:46:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	cezary.rojewski@intel.com,
	Julia.Lawall@inria.fr,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()
Date: Thu, 13 Feb 2025 15:45:43 +0800
Message-ID: <20250213074543.1620-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnr287o61n96ziDA--.2695S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4xCw1xCryfAFy8ZrWfGrg_yoWfZFb_Wr
	4kZw4xWa4UAwn7Kr43JrnYvFnag34xZFy0grs2qF48J393Gr4Yqr45Kw1qkFWkWa48GF13
	CrnrW3yq9ryxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjBWlPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAMA2etn6wN2QAAs7

Check the return value of snd_ctl_rename_id() in
snd_hda_create_dig_out_ctls(). Ensure that failures
are properly handled.

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


