Return-Path: <stable+bounces-23530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D6861D3E
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 21:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D250282C73
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266E145B38;
	Fri, 23 Feb 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JfknjjIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DE1448F8
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718652; cv=none; b=uapjBvL57aLBDCqvropJxDvl9vGyQfZGOWMeKRpSP/sjp+kESYdWGz7mIdBDDbz3YGn/H5tFv5mKQAVDI2pXZO1Y3vFragd8x1yLD3SnU49EYv36zEGG6l3fujuQaI+lvarP1JkercriPbpUgOCwONrORM1ZcKMaQTvar1xmIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718652; c=relaxed/simple;
	bh=9cEDsIi8vRUs821xVTfotIwh6nb7wOR2IdPnx9HNDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVpEtL+m+0PnlRam1SXp8AUYAB7LCoe62PvRvJ3qdU9Cjf1rvTTWMl/acrIgN7GTqlkwtJa7iSuFkQ3Jg5rLdpmmIkGZVxFVh/VLvSo2Jlgyk+7q7eBtnSo/1kU+IPVx2kjL1hO9lBGuP0hgd+r7pzb55ZApr5J3+MMWdCklfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JfknjjIn; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThLYs49M6zDVP;
	Fri, 23 Feb 2024 21:04:01 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThLYs1CxQzqSX;
	Fri, 23 Feb 2024 21:04:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708718641;
	bh=9cEDsIi8vRUs821xVTfotIwh6nb7wOR2IdPnx9HNDH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfknjjInQug3qdZGhwqvNpZPx7gaVjnaWd8pJ7emv2KpVxsH4x/UtqnHs+8NFJgDj
	 WchxVjpycDUWTgmHLsTCbSbvJKPyyTAQ86rBp71J+/DZcFdqgTZayz1gju40xLYBzz
	 D+Xs0yJQOSkkMyQ7o4btN9r19WF4Ci7mUOTZ0sMM=
Date: Fri, 23 Feb 2024 21:03:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Message-ID: <20240223.eij0Oudai0Ia@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
 <20240223.ieSh2aegurig@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223.ieSh2aegurig@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Feb 23, 2024 at 08:59:34PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 23, 2024 at 08:05:45PM +0100, Mickaël Salaün wrote:
> > selinux_lsm_getattr() may not initialize the value's pointer in some
> > case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
> > selinux_getselfattr() to avoid an UAF in the kfree() call.
> 
> Not UAF but NULL pointer dereference (both patches)...

Well, that may be the result (as observed with the kfree() call), but
the cause is obviously an uninitialized pointer.

