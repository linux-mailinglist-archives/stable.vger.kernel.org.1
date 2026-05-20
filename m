Return-Path: <stable+bounces-249815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCsEMlKYDWoMzwUAu9opvQ
	(envelope-from <stable+bounces-249815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:17:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38158C345
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 001CD30228DF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1E63BCD34;
	Wed, 20 May 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yxRgxDiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BF30F545;
	Wed, 20 May 2026 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275811; cv=none; b=FZXrsbqcinv9mJNJbSRXa7CTA8Uf+mu9HHds+kUZNJ8ChirXMxcy+XMn2AhF1ULw3vscCic5o4OMkhydTMxSgoOCcISa0VGBnUiZMYS1w8TX0ejF64Ffg4J+oCeX0WnrtmIPbCgSzLrYeOkppqsfeCGVVyXo5ZIZNo+xGE4w65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275811; c=relaxed/simple;
	bh=u7L7RLWnfxUW+FIqd+ScvAFUVSq0TEQuHeL9i1BVrSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX7sL6afMrYnagDo0eJqeWEgo2o0TvdGChTE2mrKapcQJ2c6FKomYJUxBDVOXpu+7acbq2piYOflAzdOihCewe/30qOo8vJk/NL3zZL/A2XVGqWUKadqohIFNlDzGQ7yVUaySs0ysbVenRGDxIMwPoZn066mYEkVKgkeCMONzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yxRgxDiW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6ED1F000E9;
	Wed, 20 May 2026 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779275806;
	bh=T+4a7qii4AuPx2XAjeXrtUeNNZLMcVhSdEIO6Q4ypzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yxRgxDiWH6crbyBxk/HR5MYdKKuqk6j/k95YWnISJoFjYDpmooeVUPIML8J8biJ7A
	 HiW9lx28D2RC8qFzX3A4z2XKodDKno+3a7x+Y2tYxr/IIP+umXmJISi+ONHO2whaNx
	 V8lMcDjdungywCVkWq00uQTL7FKIFiRtIAFmAP6Q=
Date: Wed, 20 May 2026 13:16:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: mct_u232: fix memory corruption with small
 endpoint
Message-ID: <2026052038-nemeses-bronze-b08c@gregkh>
References: <20260520101452.657643-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101452.657643-1-johan@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249815-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6B38158C345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:14:52PM +0200, Johan Hovold wrote:
> The driver overrides the maximum transfer size for a specific device
> which only accepts 16 byte packets for its 32 byte bulk-out endpoint.
> 
> Make sure to never increase the maximum transfer size to prevent slab
> corruption should a malicious device report a smaller endpoint max
> packet size than expected.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

