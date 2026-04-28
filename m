Return-Path: <stable+bounces-241466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HNyAcEd8GlYOgEAu9opvQ
	(envelope-from <stable+bounces-241466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:38:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D59E47CD4F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A2E4301A50F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF5394787;
	Tue, 28 Apr 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgB4FoWG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A689392C2F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343931; cv=none; b=PlmT0OCIt2jmsQk9hK0cTSUK5PonLZLP085+Hc1ULvX15sgCT3HETIyqn1HRFzPapI3LDER1TSDvYv53k90hRzCQ3TyNyeBPCdFzQof/qeO/DKB2uV0fWtVYRG60h/VDuC3COr/Vvv9vhob0QG2OsD6eJsgEEDWdcN4vlBNsxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343931; c=relaxed/simple;
	bh=HOcm4qkDWglYvDINF7knSwgT+XKsrEoWBufD27DaLn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M1ELjfbIy6igxydDlQxQsD0gk6KLdBXG9bI+LHCXd+d4OBFH/yRhbs6Wkib0l8JxZhNAoM/Ne9QhuUPimf5/0gBdVqHMMRQ8BRrN0HjUhNUkD7vzNNMxEzEPNX+Ywze/+nOv9mWqcX3+E3845xqJQfoFtdoV8jVIb+RLE6JcOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgB4FoWG; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6587cee8b57so2554032d50.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777343929; x=1777948729; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmbWusNrp2+62MHdadegYDv0GRGbm1Yqlz33D4lYo60=;
        b=kgB4FoWG6nEoI6bfCMt6yj+v2FdTWdQJ+iUM55CMSPioVRi9gv+vQOXnPLJfwLwutY
         D7Be0Pshx+Lu7SqF91X6i8+koDaEQWgyVhwY3VRf6BavuD5vC92VnDntFkEPXdyqLPoC
         C0XpMyJwXUVhtezeS4jykoAr/Fnz0GqXLctk5AYTCOuoaOSLJUmfu3MYNN6+V3Ba1yV+
         J/IUbaHIkoSMJBImtemFtoCtHV8p8kptjoP2MhMB3CiluvX9IKEtA/CueRyMBgYM03ld
         LPcB7iTmHp2DgizSDSH4W9Mfp6j5ZC6Ua8QekrXFPUX9YkpXpXbpq8F76tK630z+Wc5Z
         Av6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343929; x=1777948729;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmbWusNrp2+62MHdadegYDv0GRGbm1Yqlz33D4lYo60=;
        b=DgQcEmhRcRwvdhq2PEMeiQ0e5la1GXxCmPObZetogmj3ggQOrSG+8WuTKc3GdcP3UM
         8Ju6a2vcl02/vk2x1XQnCSVME9Rm1dA/i5AhtKmjVvblzQLzVTpDRLyYa6zifcs/S/VQ
         xBBI1b9JWZt9QaGdwt69u0cOvvuyZZm2yFfj1Z54yjQSHeYx+9vMNK5VHoW6kj/7L11Y
         YeM8M5D0cErG1fp+JzrNMLMNWjL5sKg9Wo1LilcZFYmZOqB1GbX/9hG2+lFTj1WBB8bY
         RmelEMzxmjWHpARcRj2lStUKKqsqcPY366pIstyF7ebKCQnm4UP5qWQHr2kpCHgpOI4Q
         oAEA==
X-Forwarded-Encrypted: i=1; AFNElJ9Bwmx7QYfnhyy0/HJ5uUPe7TtIKoIWj65w0Bk5iNnNJklD7kT3HHrPAEeQu8jrDyW+z6GLXQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7NJmZeMSXeBKPJ2cgmDFTLA2zzHC2jTxOTVnmmJOtVV5yATW
	a+IMFprpCvZIylnTnVAlZW1LIZnsq4moFBkJol0Rf6ECAz3X93683HuC
X-Gm-Gg: AeBDievmWRxB9crFOmRq9tl/2OKld5p9trxvAZMPoTfRWxmnKez6E9esHqe2UnO+XV9
	ctwNHTki7unQrW4iBIvkpnGmE0gJy9+o9FiAAOlQoGknrSEOlK3uUuoJ5POoypKJuBt0pI4o/Xy
	BejtU4zNbZdXyJwDrnXPA1ZazGqsX8kG8vNW6oepfXcTWxAPjJU9SO838+JgVxW35ZKEihLNC1W
	PQHpkajYiaOTsQ0NUfI5a02EHoWlKUYnc994H1sn8hB7LR0jguuYy4zrgjD4CxVF1ieeyS1pOmM
	gmErGObI+v5RwY6IG6bjpbPHFXX0N4TTYP22CHtsy1y4XT9m4kJs8xGFjGgC0GLyXqoVVhjaHOR
	wh2brliaws5VYBpes7leYZRtGOjxeFOSf6DMhHrP9m7MAsPHfkfpHuGoqKJlBHR7+oqsHKefERs
	1tp7vcRSw9twUsXiyeL84g5Aqx0RXCMyRr+MNQRNfasFQZdh5bSC0/AHQs5MuzVAv3uwV86hMc9
	bTDndUYBoWt
X-Received: by 2002:a05:690e:1289:b0:651:b7e7:eff3 with SMTP id 956f58d0204a3-65beed93be7mr976664d50.19.1777343929142;
        Mon, 27 Apr 2026 19:38:49 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bee2afb03sm710987d50.8.2026.04.27.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:38:48 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 27 Apr 2026 23:38:41 -0300
Subject: [PATCH] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on
 platform_clock_control error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrm3SqToQr2JcDLVq5Ucyg4Ih3
 N1Rl9/ivQWSRtMEh2KBqC9L9ugz3KYAuYX+qmjnbGBiTzsusX6PEnHq9o4YO2kbbDU0WFXkPJU
 c/FYgx0PUi82/8fH0d3rWd5Xxe4N1/QCEw0s+egAAAA==
X-Change-ID: 20260427-bytcr-wm5102-mclk-leak-88016072a63c
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Hans de Goede <hansg@kernel.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=HOcm4qkDWglYvDINF7knSwgT+XKsrEoWBufD27DaLn0=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJkfZDe/Su9pc417zDl/mqKizyx9MRHVP5eEPq3YlcV4c
 9uOh7t8O0pZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAi628xMiwXin4fry7OrWWd
 //97TNlxo8cHzm4VcRFKLjrSfGmOsyIjw09xvehKlZn6h7n9n9aKXTyczv7c47XO3HuhzR6Vk1x
 +sAAA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 6D59E47CD4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241466-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,linux.intel.com,linux.dev,kernel.org,perex.cz,suse.com,gmail.com,opensource.cirrus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

If byt_wm5102_prepare_and_enable_pll1() fails in the
SND_SOC_DAPM_EVENT_ON() path, platform_clock_control() returns after
clk_prepare_enable(priv->mclk) without disabling the clock again.

This leaks an MCLK enable reference on failed power-up attempts. Add the
missing clk_disable_unprepare() on the error path, matching the unwind
used by the other Intel platform_clock_control() implementations.

Fixes: 9a87fc1e0619 ("ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index 4879f79aef29..4aa0cf49b033 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -170,6 +170,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		ret = byt_wm5102_prepare_and_enable_pll1(codec_dai, 48000);
 		if (ret) {
 			dev_err(card->dev, "Error setting codec sysclk: %d\n", ret);
+			clk_disable_unprepare(priv->mclk);
 			return ret;
 		}
 	} else {

---
base-commit: 98421d94a1a6dcc3e8582eb62bedeccecda93339
change-id: 20260427-bytcr-wm5102-mclk-leak-88016072a63c

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


