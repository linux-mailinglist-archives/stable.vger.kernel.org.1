Return-Path: <stable+bounces-226979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLk4NQFYumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:45:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDDF2B724C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B192B3064E27
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376321D618A;
	Wed, 18 Mar 2026 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq35wEC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE530361649
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819781; cv=none; b=ejsuegCkzrS5W3QgoMPRB6oWqKvhnUh+ylPzhxgfgPJLC4ch35MzECoTOJ/ETeuNL3zr76IYr9OmlpS1jTnKohDOijX4kX94ZrdLAvOkaKkLj+VZatslZmpuY3DihwYJUAQIikhrJCb6JZsZa9NPC59u7bl/jLoU1ebCEWcupdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819781; c=relaxed/simple;
	bh=FjvdqkbAnoJYmzumL6p/BibiNCrIHozXex+jsqN+JEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAbuPixgIgC1L+RnWLJQyIsDRqil4idLSm2ey5sJI1rVQ8N9xOkG+A/KA3GTnNZQBsmXeldL7yJ00B7rgh8nJkMh6b0o478dTGxoAx1JHp8cInZjmYMYjmQrRmZWr1ozooW0OcmQy0TIEFKEecjeSKm3BxnSV95ypjcQSPPjHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq35wEC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D40BC19421;
	Wed, 18 Mar 2026 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773819780;
	bh=FjvdqkbAnoJYmzumL6p/BibiNCrIHozXex+jsqN+JEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uq35wEC4COgbHwhgr2YWSgsdekwpZvDWr0zhsmGZcvtM4weT3V4XmcAGfbH0kF5Pe
	 usd8/WsDFtNYS9FvP3KwcDPIhqIxzYlKNw3kPgwfKvo5ORUeJFv/ba/E0plwdJwgnv
	 LbLFeMyaLrF/WWPS1ou69w1CH5FI7ZAxXKEpDBhkv8FOPzJ+VPa9i1K5MqZlGVvN7v
	 eKGCqhlAV904qoDMLuwomKNIFP3sV0cQFN8PyhLpI/AIzu7d2TDCSSFx1ZcR8Sn8Ma
	 DPBw5qKfmINieTCh/GBg5YYdHnY7sUvaIzO1fNgO/h79KylQBYbrm/tC1UyKjmR109
	 vRJ9fFgyoK3hg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w2lYP-000000004bE-3zJh;
	Wed, 18 Mar 2026 08:42:57 +0100
Date: Wed, 18 Mar 2026 08:42:57 +0100
From: Johan Hovold <johan@kernel.org>
To: PS10 PETER HONG =?utf-8?B?5rSq57m85r6k?= <peter_hong@fintek.com.tw>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: Post-facto backport request: USB: serial: f81232: fix incomplete
 serial port generation
Message-ID: <abpXgSLJ6s_JJ4lJ@hovoldconsulting.com>
References: <5bcf02b5-3fe5-466e-a1da-0e5a2e62fd5f@fintek.com.tw>
 <abkBUCw0BTh4wfqs@hovoldconsulting.com>
 <fa0765de-68cb-4bac-b7d7-e2b47946aac1@fintek.com.tw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa0765de-68cb-4bac-b7d7-e2b47946aac1@fintek.com.tw>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-226979-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 6DDDF2B724C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Peter,

On Wed, Mar 18, 2026 at 08:46:28AM +0800, PS10 PETER HONG 洪繼澤 wrote:
> Johan Hovold 於 2026/3/17 下午 03:22 寫道:
> > On Tue, Mar 17, 2026 at 10:21:17AM +0800, PS10 PETER HONG 洪繼澤 wrote:

> >> I would like to request a backport for the following commit to the
> >> currently supported stable trees 6.1.y, 6.6.y, 6.12.y and 6.18.y
> >>
> >>     cd644b805da8 ("USB: serial: f81232: fix incomplete serial port
> >> generation")
> >>
> >> Reason:
> >>     This patch fixes a stability issue where Fintek F81532A/534A/535/536
> >>     devices fail to initialize all serial ports during fast load/unload
> >> cycles.
> >>     The fix involves a dummy read to clear the device's stale internal state.

> Typical users are unlikely to encounter this, but one of our customers is
> currently facing the issue. They have requested that we submit this patch to
> the stable tree so they can utilize the mainstream driver without needing a
> separate vendor driver.
> 
> In theory, applying this patch will improve the product's overall stability.
> We would like to see this integrated into the mainstream kernel tree.

Sounds good.

Johan

