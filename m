Return-Path: <stable+bounces-69946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD6995C6CF
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58594285B6E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3513C80A;
	Fri, 23 Aug 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7o6Am2w"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE613C918
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398951; cv=none; b=aBn9vsjs1eCqHQzX60HwPhg4NyZUamF42s41OnrgASKV/+uy1KtEQ2aeFdTZTz0P/YVwhGc6kpnE1iwLbaOPglLT2i+ZuEhSmdE0NdR/0pYTQeLN60jYOVQ/AkzMTVYKyTfLFBcj3IArIuqAncKkK/rUZqcQIGkrn2YL7HpXXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398951; c=relaxed/simple;
	bh=waVdNaNcgv1cpAt/y+iIT5qsRqBFEt6gHy5JDQfJvWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJWJ8gGToYgBlocAa/EXTO11mEIelmrFzaAXODsofYUbx4SRaghIqiKRkLwKlReLypvH5YvCb2sPM4LXnWaeVkP/dYwd7VN2AJMNSzo3eUX/XDmXNoa7Er8/4Vb12nCh5qHAs+ZoIR5scw90W0XJ0hR3UT9j+J7P+uw2uPe+doo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7o6Am2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724398947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i5EJL4/rXMHM8SIGbQ/xMlr0QEf1hlyt7Qs6lkj+jhw=;
	b=h7o6Am2wukBq5A6FBh+GwJbypKdHRFkD3PYEImAh/zEMrzPvyw+xBuK77Xk8+X7fdspR8n
	Ce84RG6qtIWvx+mrvcqpGwAaJ921iTKLUrkkxFLcZHxD/8N/i6LYH4h5ALKD4t9DuiFiId
	6geVuw1rq4Z3ZTV+F8uRuh8Bs/ArN2I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-Zo5Tv5mKMAuTqU6enX5_xg-1; Fri,
 23 Aug 2024 03:42:24 -0400
X-MC-Unique: Zo5Tv5mKMAuTqU6enX5_xg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 062F21956048;
	Fri, 23 Aug 2024 07:42:22 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.144])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41E4919560AA;
	Fri, 23 Aug 2024 07:42:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.11 regression fix] ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards harder
Date: Fri, 23 Aug 2024 09:42:17 +0200
Message-ID: <20240823074217.14653-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Since commit 13f58267cda3 ("ASoC: soc.h: don't create dummy Component
via COMP_DUMMY()") dummy codecs declared like this:

SND_SOC_DAILINK_DEF(dummy,
        DAILINK_COMP_ARRAY(COMP_DUMMY()));

expand to:

static struct snd_soc_dai_link_component dummy[] = {
};

Which means that dummy is a zero sized array and thus dais[i].codecs should
not be dereferenced *at all* since it points to the address of the next
variable stored in the data section as the "dummy" variable has an address
but no size, so even dereferencing dais[0] is already an out of bounds
array reference.

Which means that the if (dais[i].codecs->name) check added in
commit 7d99a70b6595 ("ASoC: Intel: Boards: Fix NULL pointer deref
in BYT/CHT boards") relies on that the part of the next variable which
the name member maps to just happens to be NULL.

Which apparently so far it usually is, except when it isn't
and then it results in crashes like this one:

[   28.795659] BUG: unable to handle page fault for address: 0000000000030011
...
[   28.795780] Call Trace:
[   28.795787]  <TASK>
...
[   28.795862]  ? strcmp+0x18/0x40
[   28.795872]  0xffffffffc150c605
[   28.795887]  platform_probe+0x40/0xa0
...
[   28.795979]  ? __pfx_init_module+0x10/0x10 [snd_soc_sst_bytcr_wm5102]

Really fix things this time around by checking dais.num_codecs != 0.

Fixes: 7d99a70b6595 ("ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bxt_rt298.c      | 2 +-
 sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
 sound/soc/intel/boards/bytcht_da7213.c  | 2 +-
 sound/soc/intel/boards/bytcht_es8316.c  | 2 +-
 sound/soc/intel/boards/bytcr_rt5640.c   | 2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   | 2 +-
 sound/soc/intel/boards/bytcr_wm5102.c   | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index dce6a2086f2a..6da1517c53c6 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -605,7 +605,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(broxton_rt298_dais); i++) {
-		if (card->dai_link[i].codecs->name &&
+		if (card->dai_link[i].num_codecs &&
 		    !strncmp(card->dai_link[i].codecs->name, "i2c-INT343A:00",
 			     I2C_NAME_SIZE)) {
 			if (!strncmp(card->name, "broxton-rt298",
diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index c014d85a08b2..df3c2a7b64d2 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -241,7 +241,7 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_cht_cx2072x_dais); i++) {
-		if (byt_cht_cx2072x_dais[i].codecs->name &&
+		if (byt_cht_cx2072x_dais[i].num_codecs &&
 		    !strcmp(byt_cht_cx2072x_dais[i].codecs->name,
 			    "i2c-14F10720:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index f4ac3ddd148b..08c598b7e1ee 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -245,7 +245,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(dailink); i++) {
-		if (dailink[i].codecs->name &&
+		if (dailink[i].num_codecs &&
 		    !strcmp(dailink[i].codecs->name, "i2c-DLGS7213:00")) {
 			dai_index = i;
 			break;
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 2fcec2e02bb5..77b91ea4dc32 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -546,7 +546,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
-		if (byt_cht_es8316_dais[i].codecs->name &&
+		if (byt_cht_es8316_dais[i].num_codecs &&
 		    !strcmp(byt_cht_es8316_dais[i].codecs->name,
 			    "i2c-ESSX8316:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a64d1989e28a..db4a33680d94 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1677,7 +1677,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++) {
-		if (byt_rt5640_dais[i].codecs->name &&
+		if (byt_rt5640_dais[i].num_codecs &&
 		    !strcmp(byt_rt5640_dais[i].codecs->name,
 			    "i2c-10EC5640:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 80c841b000a3..8514b79f389b 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -910,7 +910,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* fix index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_rt5651_dais); i++) {
-		if (byt_rt5651_dais[i].codecs->name &&
+		if (byt_rt5651_dais[i].num_codecs &&
 		    !strcmp(byt_rt5651_dais[i].codecs->name,
 			    "i2c-10EC5651:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index cccb5e90c0fe..e5a7cc606aa9 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -605,7 +605,7 @@ static int snd_byt_wm5102_mc_probe(struct platform_device *pdev)
 
 	/* find index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(byt_wm5102_dais); i++) {
-		if (byt_wm5102_dais[i].codecs->name &&
+		if (byt_wm5102_dais[i].num_codecs &&
 		    !strcmp(byt_wm5102_dais[i].codecs->name,
 			    "wm5102-codec")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index eb41b7115d01..1da9ceee4d59 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -569,7 +569,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* set correct codec name */
 	for (i = 0; i < ARRAY_SIZE(cht_dailink); i++)
-		if (cht_dailink[i].codecs->name &&
+		if (cht_dailink[i].num_codecs &&
 		    !strcmp(cht_dailink[i].codecs->name,
 			    "i2c-10EC5645:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index be2d1a8dbca8..d68e5bc755de 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -466,7 +466,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* find index of codec dai */
 	for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
-		if (cht_dailink[i].codecs->name &&
+		if (cht_dailink[i].num_codecs &&
 		    !strcmp(cht_dailink[i].codecs->name, RT5672_I2C_DEFAULT)) {
 			dai_index = i;
 			break;
-- 
2.46.0


