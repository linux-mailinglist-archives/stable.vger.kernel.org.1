Return-Path: <stable+bounces-224518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JVfLTZHsGnFhgIAu9opvQ
	(envelope-from <stable+bounces-224518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:30:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100FE254D02
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1951230A5869
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD35337B9D;
	Tue, 10 Mar 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqpYPpuU"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B743C6605
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160216; cv=none; b=og3FX8LdNym5ngJRObfGOelj227kHXWpfyeYltqle5aD4hMZEUn6KTOaGiCEs8EL8u3oR9Tj/8Q5RaxEmUYPervKhs2eL2e/VeV9uXf9fFcIUOQA1hyh4vZrlD06G3kfgET/VjbR+pD7Rstu49M4atpNYVunXR4bI7xTt7lZLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160216; c=relaxed/simple;
	bh=8oegJtOi03HsgN93creTDzIpex0OLle0ko4k6FIeH1w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jwxhg89Q7/roreHP4rGbpvmMZvnnohTTRMk698W0wgoYWFZmE2CpvxRQoYM9TLqVvd3VhZPS8217z0+DW/d//sQaEF8ZwHvx56baYA9Cp8UcCHER/XUwxnUTKbxVapg2XNspYjcc7RWeM/951v0W89BHcQjxiFaFn1SeJAmQ7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YqpYPpuU; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773160211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKuZ7sCTA23O6UMLzwIK0nZOTeVT/y7oS3+4wC3Dplg=;
	b=YqpYPpuUFMvPakjiAl1Q2H5dZcCDlq0qYcNktSN2LvQlC4RB/QAnT6gNg63ahA2npf0g59
	6427GcmRJjCT8rIgSWoMCgyMok2yhenK7NLlKF9o57DVwAMLJNSuqzid6jbgnrhT12yv8Q
	OaeCQbkBNT19blXwzAhCxMTUhnd3h08=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v2] ALSA: aoa: Skip devices with no codecs in
 i2sbus_resume()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <878qbzradt.wl-tiwai@suse.de>
Date: Tue, 10 Mar 2026 17:30:01 +0100
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <933E291B-23F2-4144-80F0-EC5730F65B75@linux.dev>
References: <20260310102921.210109-3-thorsten.blum@linux.dev>
 <878qbzradt.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 100FE254D02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224518-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 10. Mar 2026, at 16:07, Takashi Iwai wrote:
> On Tue, 10 Mar 2026 11:29:20 +0100, Thorsten Blum wrote:
>> --- a/sound/aoa/soundbus/i2sbus/core.c
>> +++ b/sound/aoa/soundbus/i2sbus/core.c
>> @@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
>> 	int err, ret = 0;
>> 
>> 	list_for_each_entry(i2sdev, &control->list, item) {
>> +		if (list_empty(&i2sdev->sound.codec_list))
>> +			continue;
> 
> This can be even outside the loop and immediately return 0, as the
> remaining part is also the loop of codec_list.

The i2sdev pointer is only assigned by the outer list_for_each_entry(),
which iterates the controller's device list. Since each device has its
own codec list, list_empty(&i2sdev->sound.codec_list) must be checked
inside the loop; before the loop i2sdev is uninitialized.

Thanks,
Thorsten


