Return-Path: <stable+bounces-75180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A097333D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07A51F24E02
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E43199948;
	Tue, 10 Sep 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0atjuu2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA1144D1A;
	Tue, 10 Sep 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963982; cv=none; b=vAexUF2kPV8wJIIsoMbnlwFfv/HabJMUP1cLanffNNX/rvQ3F0aIAXtrkBME6TsHTzaGMbF47xE6jfQYieZy6ztx+dpdeFl9i53eDBjGX30aPWSSS0Qhr1tEzZB8IBDX7tn2mKPJhc4JDIFRTqGhPmMg/9rekzmmORlBtOO0MBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963982; c=relaxed/simple;
	bh=vZ7BcHkwcRdDQj5PJkwscCtWWyPoJ7zV2w9CHc2sifk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMVO/EjWLj3NeCJzDwCN0xyTm7lXL8IQubSs6DCCQThuPily8QAkrjRC+6Uzoh5SXEESV6Bt3uYrTvftyL0j6yxAWduV7zVseJhe6iNpyZKBb2urJcD7aR0klod7wAZW1WA8DUn6lq/yz2ZwDoM0tp2IIU0B/Lh9411pSu43+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0atjuu2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2784C4CEC3;
	Tue, 10 Sep 2024 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963982;
	bh=vZ7BcHkwcRdDQj5PJkwscCtWWyPoJ7zV2w9CHc2sifk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0atjuu2uiRgipcCQXgMYdnPbnrNRsS1FMA12QR1YhBzolrIxiRHYH8Nm1hxvt6qPn
	 u7spOVyjbXBptfp9yqWLOJwvX+YkEDdzws0LkS0u4utEUSFs9I/LD5fdxct8Gvk4F7
	 nkJjj3sZu0kTTfunzeB2szHn+sEyJ4/xbGIyXGfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	robelin <robelin@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 003/269] ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object
Date: Tue, 10 Sep 2024 11:29:50 +0200
Message-ID: <20240910092608.355411694@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: robelin <robelin@nvidia.com>

commit b4a90b543d9f62d3ac34ec1ab97fc5334b048565 upstream.

When using kernel with the following extra config,

  - CONFIG_KASAN=y
  - CONFIG_KASAN_GENERIC=y
  - CONFIG_KASAN_INLINE=y
  - CONFIG_KASAN_VMALLOC=y
  - CONFIG_FRAME_WARN=4096

kernel detects that snd_pcm_suspend_all() access a freed
'snd_soc_pcm_runtime' object when the system is suspended, which
leads to a use-after-free bug:

[   52.047746] BUG: KASAN: use-after-free in snd_pcm_suspend_all+0x1a8/0x270
[   52.047765] Read of size 1 at addr ffff0000b9434d50 by task systemd-sleep/2330

[   52.047785] Call trace:
[   52.047787]  dump_backtrace+0x0/0x3c0
[   52.047794]  show_stack+0x34/0x50
[   52.047797]  dump_stack_lvl+0x68/0x8c
[   52.047802]  print_address_description.constprop.0+0x74/0x2c0
[   52.047809]  kasan_report+0x210/0x230
[   52.047815]  __asan_report_load1_noabort+0x3c/0x50
[   52.047820]  snd_pcm_suspend_all+0x1a8/0x270
[   52.047824]  snd_soc_suspend+0x19c/0x4e0

The snd_pcm_sync_stop() has a NULL check on 'substream->runtime' before
making any access. So we need to always set 'substream->runtime' to NULL
everytime we kfree() it.

Fixes: a72706ed8208 ("ASoC: codec2codec: remove ephemeral variables")
Signed-off-by: robelin <robelin@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Link: https://patch.msgid.link/20240823144342.4123814-2-spujar@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-dapm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4018,6 +4018,7 @@ static int snd_soc_dai_link_event(struct
 
 	case SND_SOC_DAPM_POST_PMD:
 		kfree(substream->runtime);
+		substream->runtime = NULL;
 		break;
 
 	default:



