Return-Path: <stable+bounces-266561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Per2N6egMWpqogUAu9opvQ
	(envelope-from <stable+bounces-266561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:14:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8C694E0D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:14:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QaIRT6Oa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266561-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266561-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6BDB307E691
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A53DE450;
	Tue, 16 Jun 2026 19:14:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D73DC87A;
	Tue, 16 Jun 2026 19:14:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637253; cv=none; b=ZEphaOgdzcboKLQ+bWFKrA27nc/zuk+l02tYbJU/5Gudf3eXmy0QHP+GlSrw8FcsV2S+K2RDlX2aE/fME5r1jv+HVVGHpUEvrj4NCeKxPsoQgS0LJS2e46ZWZswH0IhCzbJOwWhdHsTRZ5SEAXUvtDeRy2ICFE2ILrDQXxLf/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637253; c=relaxed/simple;
	bh=ld6Li5sYyBFy8HfAbk5VPafFYDwUe2SSZ7hdSpMIWwU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bXTCNI6Ysz3rH614DjPzFNpbReGTJu6xxAfTd/CZ+jy8DD/nCl3TLrJqZQDJO3AL1NKh4sHRW9wQHgKBZtRhefDu1o5wnxlNp6RyA+tTkOcSsoM+UyiL02vJaPV2zwscoTydt7UePg4SOMZEKvZLGzAzDGb95BTNDIo5Riv/5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaIRT6Oa; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781637251; x=1813173251;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ld6Li5sYyBFy8HfAbk5VPafFYDwUe2SSZ7hdSpMIWwU=;
  b=QaIRT6Oae7Nb4OHyjkcEs9hqnOuLPiY56s76ixTKdABtgH22CM7Xx9xJ
   PYsOpfVKwZZpB3AQcphrgmdEF+1LELljjHnYZ3rx9aly5I3kXPGmyGwFN
   GfLHNl3L9sLoFM///uf2eky9lNqtEE1+TNVJkn4hrCVeA74ezk1zorDQh
   Hnfv7int+cfmFdZpkmVR9kLT0lWyvIlosalJES6BuxPd4ZunopeGeGddp
   5EFwQZmbPgcAT8apj6KJIwvIYaELEDWNTXAU9upK+Y5PYWcbvb+iWdT0h
   i0Wg0WMb6Vik+vwXg9LOkNJsW6jz9vI9SZ/Y2goiaGVUxJl59paLBZ/UF
   w==;
X-CSE-ConnectionGUID: 3PWmhW5zStqSv1jUY6TTJg==
X-CSE-MsgGUID: +J1UOlKcT5+HrnhyTfcxmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86250533"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86250533"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 12:14:10 -0700
X-CSE-ConnectionGUID: CbN7Ya9nTYOtngFQ6I/7Bg==
X-CSE-MsgGUID: CTCSkLcdTYyFWUXNKEZaKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252963050"
Received: from ettammin-mobl3.ger.corp.intel.com ([10.245.244.170])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 12:14:08 -0700
Date: Tue, 16 Jun 2026 22:13:47 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
cc: =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@intel.com>, 
    =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
    Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
    Jaroslav Kysela <perex@perex.cz>, 
    Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
    Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
    stable@vger.kernel.org, Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
In-Reply-To: <20260612181314.5577-1-alexander.kaplan@sms-medipool.de>
Message-ID: <e5a56b3c-1fd7-35ad-f072-e490e2b471a9@linux.intel.com>
References: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com> <20260612181314.5577-1-alexander.kaplan@sms-medipool.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266561-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.kaplan@sms-medipool.de,m:peter.ujfalusi@intel.com,m:peter.ujfalusi@linux.intel.com,m:tiwai@suse.com,m:linux-sound@vger.kernel.org,m:perex@perex.cz,m:kai.vehmanen@linux.intel.com,m:pierre-louis.bossart@linux.dev,m:stable@vger.kernel.org,m:uma.shankar@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[kai.vehmanen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.vehmanen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCF8C694E0D

Hi Alexander,

On Fri, 12 Jun 2026, Alexander Kaplan wrote:

> That is probably just the sink.
> As long as KAE was never active in the display power cycle, my TV plays multichannel LPCM audibly on the front pair, even though its ELD advertises 2 channel LPCM only.
> The bug signal is the switch to multichannel itself.
> The first 6 or 8 channel stream after KAE activity plays silent, wedges the pin and everything after it stays silent.
[...]
> That said, after your LNL result I agree a PTL only model change is the wrong shape.
> I can gate the silent stream type per pin on the ELD connection type instead.
> DP pins fall back to the SILENT_STREAM_I915 path and native HDMI pins keep KAE, on all KAE platforms.
> That matches the failure boundary on both of our machines and keeps the power benefit where it works.
> If that shape works for you I will send it as v2.

gating on DP pin type is less than ideal as this would impact USB-C dock
usage, which is probably the most common scenario where the display audio 
keepalive helps (to ensure desktop/UI sounds are played out from the start 
and not eaten up by the HDMI/DP receiver taking their time waking up).

I'm asking around internally for more test results based on your findings, 
but one quick test to make if you have time:
--cut--
--- a/sound/hda/codecs/hdmi/intelhdmi.c
+++ b/sound/hda/codecs/hdmi/intelhdmi.c
@@ -445,6 +445,12 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
                                        stream_tag, format);

        if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
+               /* do not reenable KAE if multichannel streaming started */
+               if ((format & AC_FMT_TYPE_NON_PCM) || (format & AC_FMT_CHAN_MASK) > 1) {
+                       codec_dbg(codec, "HDMI: multichannel stream, disable KAE\n");
+                       return res;
+               }
+
--cut--

The driver has disabled KAE just before this, so this is worth a shot. 
If pin is still wedged, then the problem occurs already earlier in the 
sequence.

Br, Kai

