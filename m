Return-Path: <stable+bounces-250418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOPVLUDyDWro4wUAu9opvQ
	(envelope-from <stable+bounces-250418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E25944CE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D61A335645A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A03E5ECF;
	Wed, 20 May 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MG8gkgBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F33546D0;
	Wed, 20 May 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295362; cv=none; b=YDWCGL2xOIlXVh7GEt1e4t+xcCBgRvQUmuvsFCkSfn2yV4rLUR2fMPdssrnd3BN74EttVhgl7TQsuDDhbcKE3navqjQMUFrBI0utGOR/xCaDlB+gBkm7imbdVPc0KD8qiz+BZQknK+yjS/ua2Ifh8VbXTmxQRcb4bD4AHwelkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295362; c=relaxed/simple;
	bh=9rD+s4FXSsacKXoCw5MCReDe5Vdr5eaIMTuZ+MVxW+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW5kY5mvNPTwAotpHJhXFBsmvFI77A0XNNVBkKNeOrkU6Z+zQIfV+SEj/Cpcktp/5/M0oDuhf8eaIUVVBlGw5ayElr41zTdHgDRIOjNxsbEMQxqakOxEnJCcQKBL20J6QI1E9J3Lym086GzZmQLKJbe3O+RSsXqPFDj3rYQXfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MG8gkgBo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF061F000E9;
	Wed, 20 May 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295361;
	bh=VCLDKlc3RX3Uu5udX4evR6xePk3F3yCGNDD385v5KV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MG8gkgBo0bKPdACYJK8jCIg1ZL1SmMLlU+1D79b4dSSZmo98KZgL4PkudGoGH7YDN
	 yL6BGebm2yGDycEtUNNRND4cM4mR2a/MnUOBt2Uy0phagtLZ3jyEtMx7SLWdLdWT1V
	 WoUW4cRTfxliivg3895sGdGJmin+HVvE3f9kNan8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lei Huang <huanglei@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0349/1146] ALSA: hda/realtek: fix code style (ERROR: else should follow close brace })
Date: Wed, 20 May 2026 18:09:59 +0200
Message-ID: <20260520162156.096994069@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250418-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,suse.de:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 527E25944CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lei Huang <huanglei@kylinos.cn>

[ Upstream commit d1888bf848ade6a9e71c7ba516fd215aa1bd8d65 ]

Fix checkpatch code style errors:

  ERROR: else should follow close brace '}'
  #2300: FILE: sound/hda/codecs/realtek/alc269.c:2300:
  +       }
  +       else

Fixes: 31278997add6 ("ALSA: hda/realtek - Add headset quirk for Dell DT")
Signed-off-by: Lei Huang <huanglei@kylinos.cn>
Link: https://patch.msgid.link/20260331075405.78148-1-huanglei814@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8e135bcaa28e6..cbc24d71a1115 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -2296,9 +2296,9 @@ static void alc_fixup_headset_mode_alc255_no_hp_mic(struct hda_codec *codec,
 		struct alc_spec *spec = codec->spec;
 		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
 		alc255_set_default_jack_type(codec);
-	}
-	else
+	} else {
 		alc_fixup_headset_mode(codec, fix, action);
+	}
 }
 
 static void alc288_update_headset_jack_cb(struct hda_codec *codec,
-- 
2.53.0




