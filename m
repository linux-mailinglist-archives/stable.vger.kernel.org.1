Return-Path: <stable+bounces-241706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIjzBIXh8GmoagEAu9opvQ
	(envelope-from <stable+bounces-241706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:34:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF3489040
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6C4131D1846
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70524450905;
	Tue, 28 Apr 2026 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7TTGj1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB7413224;
	Tue, 28 Apr 2026 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392154; cv=none; b=nDBBU6nWRuZp4NaeP0l+Q4/dGR4Eo7gacsJjjlNhrfKbRXQZi8JNU2rj/YE6vy3Olwa+6w0MHv1nd53Al+ldcWkslRIzLHqp+qxoWjFuwMbU6X0ux0Ke3Fgu6N3Lh0O5eTnAP9imWbqon+bMalu0N3UuIc3Y+w/Zu7ueaZfbzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392154; c=relaxed/simple;
	bh=PR0HAnHcP9FFw0OW3Pb/wZoEnXpkvSX5gNthc8F6qiA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pRJNT3zPpQSbRVUJ4pxpq8uY1yNfCmzyrvdTf3I0hFjsE7YgLx1X2COvw6DIkLc2juusfwJ37hW2Ob7MPVAUfvvotPJZe0nVg7lReX3L6JKZPtQrtESgsWNIZgWzYv8gyiaOneIdrS5old7x0fFj4+mEssXVSj4S3F6bTgXtCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7TTGj1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3048C2BCAF;
	Tue, 28 Apr 2026 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392154;
	bh=PR0HAnHcP9FFw0OW3Pb/wZoEnXpkvSX5gNthc8F6qiA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=d7TTGj1JLMspUrS4pJjw8m2t52WE6MAaG6EASicDPphkulmgsrMlDNXNCr762mZMV
	 aJ+WOCixlTi+dxqhkt2LhqU2937ePIiGIreDJKfW2+c8lip/iIAJQBC0yeJvwN8nCU
	 +6/kkDQrlTHnMMb38ICuWpftjA82BUMEpoUkl/5ekOtTMYj97c1O4xVKMqfShrFQ8u
	 Hc0nW6wYmC7MxDs0UwcAiHcBkF1/ieW2mBF/e4rbHQB5kCTZomZMCY9UTzYlUSu3gg
	 UJZ567b8R5H48SNx3ghhNxseBk+iof7rsWqV0hk+3Y7R37SDcffl4qPmZyEWkiYy/I
	 Afw8Lq5m9Um+g==
Date: Tue, 28 Apr 2026 18:02:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Icenowy Zheng <uwu@icenowy.me>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
    Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
    Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
    linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] HID: pass the buffer size to
 hid_report_raw_event
In-Reply-To: <aeXdKFJe8JyatqLR@beelink>
Message-ID: <7679n429-n1o7-s252-rs3s-q6os44979sro@xreary.bet>
References: <20260416-wip-fix-core-v2-0-be92570e5627@kernel.org> <20260416-wip-fix-core-v2-1-be92570e5627@kernel.org> <938e8afadcbf2d7b9f0397e24926224985d9c385.camel@icenowy.me> <aeXdKFJe8JyatqLR@beelink>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0EEF3489040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241706-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xreary.bet:mid]

On Mon, 20 Apr 2026, Benjamin Tissoires wrote:


> > Oops, "ghid" is misspelled here...
> 
> Damn, you're correct. Sorry.
> 
> Jiri, do you want me to send v3? Or can you fix it while applying?

Normally I'd fix it manually while applying, but kernel test robot found 
newly added compiler warnings in the meantime, so please include that in 
the followup v3.

Thanks,

-- 
Jiri Kosina
SUSE Labs


