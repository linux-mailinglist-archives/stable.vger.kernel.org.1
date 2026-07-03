Return-Path: <stable+bounces-271874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L00nOw9GSGqmoQAAu9opvQ
	(envelope-from <stable+bounces-271874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 01:30:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBC7061AF
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 01:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sms-medipool.de header.s=mail header.b=KMS73Smv;
	dmarc=pass (policy=reject) header.from=sms-medipool.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271874-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271874-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA8733028E6E
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 23:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E06D3438A0;
	Fri,  3 Jul 2026 23:30:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B712EEE97;
	Fri,  3 Jul 2026 23:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783121419; cv=none; b=Yja5dryXgRKJuMNX+1cXWw99e8HDinqIhSdCB20NkopsL7QsFjAmq+J8oA79S6yv/kRuv+88gJQ+ao9v8nFl5X306dHwyGVGhYJeYFrEOVVQBcxRe84OdVvvesGSIokF6/soUcyYi2L6W+MnShiJDFH0kmZPJLwDDSCzdrhdsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783121419; c=relaxed/simple;
	bh=SzB9tZyiwbNsckTsGonX6QEORzbCNDmomg4Mtmkw7Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9eAhYXNby1Dq43ofBW9gBkIhr2ldrO0oinLf5hqS9rsfONXcW0R5CqBvXRAYPiIH1iXD62ipCUhM5YRH0w6bG4lzdeFRWsh8gQ7AS8i3O+yyN010/E/YcvVWNllNIMYtoOgrd7wiPavSG815H5/yeJI+RfAan5GBWQQVZerKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de; spf=pass smtp.mailfrom=sms-medipool.de; dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b=KMS73Smv; arc=none smtp.client-ip=178.63.14.108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
	s=mail; t=1783121094;
	bh=SzB9tZyiwbNsckTsGonX6QEORzbCNDmomg4Mtmkw7Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMS73SmvuZ8fc/oEl+SSPz44MR4d/gM0pOSe3hvQ9X//VbMDgNZSc0x0+Ce2RKVpo
	 IL2jtZCetHc0D2QlJ25TikwgQ4vysW3ZYeFv8URUc/GKfURldhWTKwv1Lc8YZkXCpv
	 1UkXhacLC2BxusvWfdU7sP4nn2yx++cEj4hH+Ubc6KeYGk9OnbRuFcu5fNigGQjkxD
	 CfqRp0ZA3M1HWgs2orJ7TYTS/DS9bi1jVvbc5AUynufZ9Ou/jx2TEh62Ckj0PyQ1J4
	 OSuRoaeTk5wJ4MtZx5Jwtiy+4MgEmsn99nvckV5vVKyrQvSZO3EzT/d9BrnGqsKSwj
	 3T1LZv8ld38HQ==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
	by mail.sms-medipool.de (Postfix) with ESMTPS id 437EF18787;
	Sat,  4 Jul 2026 01:24:54 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
	by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
	Sat, 4 Jul 2026 01:24:52 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	stable@vger.kernel.org,
	Uma Shankar <uma.shankar@intel.com>,
	alexander.kaplan@sms-medipool.de
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
Date: Sat,  4 Jul 2026 01:24:51 +0200
Message-ID: <20260703232451.4315-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <765b713e-d2a0-6859-2923-53f8e60cb00e@linux.intel.com>
References: <765b713e-d2a0-6859-2923-53f8e60cb00e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sms-medipool.de,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sms-medipool.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271874-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kai.vehmanen@linux.intel.com,m:peter.ujfalusi@intel.com,m:peter.ujfalusi@linux.intel.com,m:tiwai@suse.com,m:linux-sound@vger.kernel.org,m:perex@perex.cz,m:pierre-louis.bossart@linux.dev,m:stable@vger.kernel.org,m:uma.shankar@intel.com,m:alexander.kaplan@sms-medipool.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.kaplan@sms-medipool.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[alexander.kaplan@sms-medipool.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[sms-medipool.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75EBC7061AF

On 01/07/2026 01:45, Kai Vehmanen wrote:
> some progress with this. I attached a work-in-progress patch that fixes
> the issue with at least one setup using Club3D CAC-2505 DP-alt HDMI
> converter to the bug at:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412#note_3543741
>
> Needs more work still, but if this approach works, I'll send a proper
> patch later to the list.

Hi Kai,

sorry for the late reply, a busy stretch at work kept me away from
this.

I tested the second, more generic patch from the work item (disable
keep-alive before audio format change) on the Panther Lake NUC.
Base was 7.1.2 with my KAE disable patch removed, so the KAE path is
active again (PTL on MODEL_ADLP), and your patch on top.

Results with two Synaptics VMM7100 based converters:

- Club3D CAC-2505 (SYNAq 7.1 firmware)
- Cable Matters USB-C to HDMI (7.02.123 firmware)

Test sequence on each, from a fresh boot:

- 2ch baseline, 6ch speaker-test, back to 2ch
- 5 rapid 6ch/2ch cycles
- PipeWire card profile switching between stereo, 5.1 and 7.1

Audio stayed audible through every step on both converters.
The register fingerprint I used during the original debugging
(AUD_DP_2DOT0_CTRL low bits sticking at 0x4a1 after the first
multichannel stream) now stays at the healthy 0x482 value
throughout.

So the reordering fixes the issue on my setups as well, and with that
my KAE disable patch can be dropped in favor of your fix.
Feel free to add, once you post the proper patch:

Tested-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>

One note, unrelated to your patch: the roughly 200 ms display
blanking on an audio channel count down transition (6ch to 2ch) is
still there.
That one sits downstream of the host (converter firmware or TV
resync) and behaves the same before and after the patch.

Thanks,
Alex


