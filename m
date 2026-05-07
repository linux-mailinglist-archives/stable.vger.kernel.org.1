Return-Path: <stable+bounces-244480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI6oIxzv+2npIgAAu9opvQ
	(envelope-from <stable+bounces-244480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 03:47:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E631E4E2144
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 03:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A083015724
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 01:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64582274B4A;
	Thu,  7 May 2026 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="e/t0Bw0e"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7E194C98
	for <stable@vger.kernel.org>; Thu,  7 May 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118422; cv=none; b=TRCvK908zOu1haRSqKL6EQbKdJQectObfpnp2GLiTEuf9RTlU0JrwMgS/Y+I5Ux9DRdMoM/aEFYXSRP6/VvlA+0LpzCob0Cf+4PAWBTABHOJgwfc+QUfS23fMte/WcZQOhOiN7U66mFMQ2OB9Xw6jtHidBQwyqySy7kmlZ3J7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118422; c=relaxed/simple;
	bh=ptahMHxAwcMzgJUkdJAwL9Np/nYEs8gByqgKb70ZGU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnXrlzYRtje8KPYERlGt7x8LgWU6bzqe6STUCLUZ0ifv+wxw4d8rmskHrFRyTlNemUi/YGvVzgBNH1M8C7YL4cSkgq4QxZapFjBuqqVsT5ITSXqPKLuoRjVgBpsPWX7xft9DXr4qxG0uDezkpVGvuxCoiF1EN6Umr1NFGFaPfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=e/t0Bw0e; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <35b45fd0-fffb-455b-b19d-5c29cc955563@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1778118408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lk0xUHftJD0rJZhHZIYmoYd2dWXW26635MabL0+A0s=;
	b=e/t0Bw0eH/FG81UNZB8PXX5CTv8G5YfwI473WJ6VQD5RryLVhi1MV/jgZAWcoWxlvxF8G7
	jTnsQzrJqpZwoMpyUabou0hxvPpdvwwXinacY0Eqgv/KGVsvG459eUmpjGgrcpsJpbbxqb
	UynFV0PS4+j+bHPupsbc2OQX8Whlaixhr9Ba8FfhA+8lS1rOJ45tqjJnHhvDEKH87dtc8w
	ID3vI7O5T29NVDel+rmtmVeIYbtjMmJmDVVwM0uczjeeYiNH7yVguVW7hNSm8PPUjqlt1p
	nqZbtFz/AVb6go4LZDV2aUwyV9TUqI3jCDw+/VaPqOq7di2UcNzbMG8lMomlVw==
Date: Wed, 6 May 2026 22:46:33 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/6] ASoC: qcom: qdsp6: q6afe: fix clk vote response
 type mismatch
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Bhushan Shah <bhushan.shah@machinesoul.in>,
 Luca Weiss <luca.weiss@fairphone.com>, Antoine Bernard <zalnir@proton.me>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260506204142.659778-1-val@packett.cool>
 <20260506204142.659778-2-val@packett.cool> <afvWsfgIz9Q-_cjH@sirena.co.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <afvWsfgIz9Q-_cjH@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E631E4E2144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[packett.cool,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[packett.cool:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244480-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,oss.qualcomm.com,machinesoul.in,fairphone.com,proton.me,lists.sr.ht,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[val@packett.cool,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[packett.cool:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,packett.cool:mid,packett.cool:dkim]
X-Rspamd-Action: no action


On 5/6/26 9:02 PM, Mark Brown wrote:
> On Wed, May 06, 2026 at 05:33:02PM -0300, Val Packett wrote:
>> The response sent by the firmware when requesting a clock vote (opcode
>> AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST) does not actually have
>> the same opcode + status payload as APR_BASIC_RSP_RESULT. Rather, it
>> returns one single u32 which is the client_handle that must be used in
>> future unvote requests for the same clock.
> Please send cover letters for your serieses, it helps tooling.  Please
> also supply inter version changelogs.

ummm:

https://lore.kernel.org/all/20260506204142.659778-1-val@packett.cool/

I even Cc'd all(?) the lists, as usual.. Oh, sorry- not stable@ I guess.

I didn't even realize the Cc from the sign-off section would actually 
immediately be used by git send-email, I thought it would only get sent 
to stable when merged.

~val


