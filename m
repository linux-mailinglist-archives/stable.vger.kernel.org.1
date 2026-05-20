Return-Path: <stable+bounces-249723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D3amJFILDWpesgUAu9opvQ
	(envelope-from <stable+bounces-249723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:16:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86D5867C4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC3B301E95E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 01:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5D2D9EFF;
	Wed, 20 May 2026 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqOkAmqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4A285061;
	Wed, 20 May 2026 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239757; cv=none; b=kvrKn+W999216CiHHQvP6z/CVhQ3cJKUAQxSfgRRpbqjiuGsO3+MrxulPxwSpaxK9JxcLE/z24O/2FEfhcDn1jQZGk2joYJjUBo3v8E6F2ZdcuwrTpVVvvZgEDQQMcWrzHFzQdMDRWG7wMqlX2x5aNDTWaYEdzaFKCHCebSKtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239757; c=relaxed/simple;
	bh=iMyq01rBZERRH9e8tzJEI2hI9k/rW8wFOEsDjxpIXI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMUpdsLub/E60Qk15igldvsrS+oQoSATHWsv/rpL97Na9t5uoujCQYfB3ghxQFm/CDi3slW6XcNtITvHWyCCqfZ1CiPX1LADVdeJpWOHoIvz+aqIBiryMBk1SO6tm392JafHNTubfJ0h5+STFmTczCu/PveQt8tVUE25lgR7hjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqOkAmqJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685651F000E9;
	Wed, 20 May 2026 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779239755;
	bh=ZCaU6+VJbWf/ON+TfBNoaRwtJMxXOyq2Ap1E51+Y6vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NqOkAmqJtSRAFLPaCEgDqX5+u0T8Nup7ZJN0BNuJoENp2sYDl2ZwRm2yDioS8GJ9U
	 nWzX/OCvD1KsoXWD1frTukwLHJLI5IbOSBotl50soKbliEXC+CSnS7KMZSc9YNNJdd
	 gIe+lu1IyKyiNJHJ4la0B6rjXDDTm/+aOmrD7d0VB5qYoKCno2py3I0lSF0CO/xDtB
	 1CE2W0/Cv/fRlO9tfFPupkf5oLJ6Qe18HenARUtIEQr43ScwAkuwx+gJ9O+yW99usn
	 t7sQcLQeo7botT90GNMWSdsCphAt0Vv201+YSWVXMVCXzM0SjoHv4Mrt7jpREXD8E5
	 6u3yuNt1YMYXQ==
Date: Tue, 19 May 2026 21:15:54 -0400
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mateusz Redzynia <mateuszx.redzynia@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y] ASoC: SOF: Intel: hda: Fix NULL pointer dereference
Message-ID: <ag0LStilQENyQa49@laps>
References: <tencent_D2D615381730920DE9B46435691FBD92C708@qq.com>
 <20260519220508.reply-0006@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519220508.reply-0006@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,intel.com,kernel.org,foxmail.com];
	TAGGED_FROM(0.00)[bounces-249723-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,intel.com:email]
X-Rspamd-Queue-Id: DD86D5867C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 08:54:19PM -0400, Sasha Levin wrote:
>On Tue, May 19, 2026 at 06:44:10PM +0800, Alva Lan wrote:
>> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>>
>> [ Upstream commit 16c589567a956d46a7c1363af3f64de3d420af20 ]
>>
>> If there's a mismatch between the DAI links in the machine driver and
>> the topology, it is possible that the playback/capture widget is not
>> set, especially in the case of loopback capture for echo reference
>> where we use the dummy DAI link. Return the error when the widget is not
>> set to avoid a null pointer dereference like below when the topology is
>> broken.
>[...]
>> [ Minor context conflict resolved. ]
>> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
>
>Queued for 6.6, thanks.

Ugh...

This backport is missing the !swidget NULL check that the upstream commit also
adds.  Upstream 16c589567a95 adds two checks in hda_dai_get_ops(): one for !w
and one for !swidget.  Your patch only adds the !w check, so the later "sdai =
swidget->private" still crashes when w is non-NULL but w->dobj.private is NULL.

I'm going to drop it for now.

-- 
Thanks,
Sasha

