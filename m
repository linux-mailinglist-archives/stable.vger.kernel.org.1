Return-Path: <stable+bounces-225755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P0vG1gBuWlTnAEAu9opvQ
	(envelope-from <stable+bounces-225755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:23:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3F2A4B80
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 604B3300E4A9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3F38C428;
	Tue, 17 Mar 2026 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U56LDD7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7538C433
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732179; cv=none; b=O4TvXygFuWb7Oa6dxJNCeQoWB6KixojmrdYMlJ2VYEj3sCrAfG4E2I1vj97fVFKxLsIJMlovXGsJgctMtIfufkwq7Q8dopqhXs6orZv1THrxjHb4Ht6FtvzhdTCuIPzwW+o6Na+mggkaohU4SMnvdLaRVvVFP1cRIB/HdIWzkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732179; c=relaxed/simple;
	bh=BEg9MEKVoGa53wgmbH/RTArYL8PbSuqzMvU/Y/4Pshw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njsvnipb7w4EzhOYEG/aPYdnMMAPGolV7lE1yhYTCnl5EmmJYSMMde/huzM5Lr2Sf46LA8dmI+ld+4OES55UB9OFNNtWEepd4bBHYPZIJ+kBxBhgEHP1c57RrGGA9UAUaFyWAFwvk+HlUopGyUMTHAHciXltFDg58SFqCLFl/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U56LDD7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4879C4CEF7;
	Tue, 17 Mar 2026 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773732178;
	bh=BEg9MEKVoGa53wgmbH/RTArYL8PbSuqzMvU/Y/4Pshw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U56LDD7J5QcwfjmkIKjJ3zsb7luSgMkPovOu0MAkh4bdaptQdnghCwwyUXdgY1cgr
	 qz9HmiNJKWLVw8zNNHfRmIkZ3EiNahKhof09/sqWLhEAAJMyT5VkywTfFUAGGv4y7o
	 bNOn9DIKBit5yoUkeIvUn4pjCGXBfkKgqQGzdYqk8T4xfOvFJMrDue9bvxAG//SQGo
	 LHYc09RqBgnxe++hVhxlaCssKTXaIRAtVT+gmhSnraHUGG/yaVlS6yGhAvgcKb54kG
	 YQy1WLnlcguyZv7q1YHSnadezEKKA3C//yahOT62rwh5njz7t2Q9QZTHmwBQUi/gST
	 fneF9jeKSEuYw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w2OlU-000000003kO-1JI6;
	Tue, 17 Mar 2026 08:22:56 +0100
Date: Tue, 17 Mar 2026 08:22:56 +0100
From: Johan Hovold <johan@kernel.org>
To: PS10 PETER HONG =?utf-8?B?5rSq57m85r6k?= <peter_hong@fintek.com.tw>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: Post-facto backport request: USB: serial: f81232: fix incomplete
 serial port generation
Message-ID: <abkBUCw0BTh4wfqs@hovoldconsulting.com>
References: <5bcf02b5-3fe5-466e-a1da-0e5a2e62fd5f@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bcf02b5-3fe5-466e-a1da-0e5a2e62fd5f@fintek.com.tw>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225755-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 72D3F2A4B80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:21:17AM +0800, PS10 PETER HONG 洪繼澤 wrote:
> Hi Stable Team,
> 
> I would like to request a backport for the following commit to the
> currently supported stable trees 6.1.y, 6.6.y, 6.12.y and 6.18.y
> 
>    cd644b805da8 ("USB: serial: f81232: fix incomplete serial port 
> generation")
> 
> Reason:
>    This patch fixes a stability issue where Fintek F81532A/534A/535/536
>    devices fail to initialize all serial ports during fast load/unload 
> cycles.
>    The fix involves a dummy read to clear the device's stale internal state.
> 
> The patch should apply cleanly to most recent stable branches.

My understanding was that this was only something you'd hit if you
unload and reload the driver which isn't something a user would normally
do. That's why I didn't add a stable tag.

The diff is a bit on the bigger side but it's all straight-forward
enough so I'm fine with backporting if you think it will be useful also
for older kernels.

Johan

