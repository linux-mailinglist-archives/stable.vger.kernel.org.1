Return-Path: <stable+bounces-240412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLNzAkmn6WmzgQIAu9opvQ
	(envelope-from <stable+bounces-240412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9EC44D1EA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CE63019909
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01B3CAE85;
	Thu, 23 Apr 2026 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTN3Pv+s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C533C9EE8
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920361; cv=none; b=TIZIuDPltPnuvmXHtBAwEL9MSKALP8MGDrSU13ASEJQ2WptL/pWhPNxltVK3++5jynL4/ruaJoAJcxyOstpPGwNEhlUi0M7G/i65DG2w036XGprktLK3S0QRDrFPGwCA0SS8DVCk+cioSSvWDvlTLyNnJ1fBQtc4OBNW1nuzpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920361; c=relaxed/simple;
	bh=MlhW2VJKxCQhQ9kEGa4PR0y/Qmll1sUW5SshdkP4nts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAxWnqbfybbL+BVAj9vQMXlbq3DBtD4NhmkZ9DHGxEhPeNtHTIk3cwe5eZNGJr9cCed0NhkHtWsFdq6DCQy8kk62cfTT3KnmHmTnDW7ZevXmHRcO2ELKflP1RnWTYY4qHOXPTKhcmkQf8AoUGI8EOsbKTotD4jQaw0WfTQXzLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTN3Pv+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530EAC2BCB2;
	Thu, 23 Apr 2026 04:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776920360;
	bh=MlhW2VJKxCQhQ9kEGa4PR0y/Qmll1sUW5SshdkP4nts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTN3Pv+sUftj2vloaE3x6zl+oOdvbZxgA3StyXm9YW57LhZdx4tFs5F/0in4gkFPN
	 1sJofgXW0kyW1WJFCVQ2scOmOjMa7a19zeJMxUVQ4T235mwXQyxQ3lyHr56oa9FycP
	 ZCdgIeX8n1iywpWcCfhcXnjhYlvtFxB7I3PI5WYw=
Date: Thu, 23 Apr 2026 06:59:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Sowell <tom@ldtlb.com>
Cc: stable@vger.kernel.org
Subject: Re: Please backport 3c863ff920b4 ("drm/amdgpu: replace PASID IDR
 with XArray")
Message-ID: <2026042306-grappling-scholar-c837@gregkh>
References: <gh5bqoabelvwdkmuvgb2ue7j3g2xw6i6w7upqsh3uefy7uxbym@3zuucinf7pqq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gh5bqoabelvwdkmuvgb2ue7j3g2xw6i6w7upqsh3uefy7uxbym@3zuucinf7pqq>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-240412-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7D9EC44D1EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 07:53:22PM -0800, Thomas Sowell wrote:
> Hello,
> 
> Please consider backporting mainline commit 3c863ff920b4 ("drm/amdgpu: replace
> PASID IDR with XArray") to 6.18.y and 7.0.y. It fixes a regression introduced
> in 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case").
> 
> Using the reproduction steps below I've confirmed that both 6.18 and 7.0 are
> affected by the regression and that 3c863ff920b4 resolves it in both.

Also applied to 6.12.y now too.

thanks,

greg k-h

