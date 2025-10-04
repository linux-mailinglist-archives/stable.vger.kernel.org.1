Return-Path: <stable+bounces-183344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816ABB8737
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 02:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C29654E761B
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E958DF49;
	Sat,  4 Oct 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL9NX17N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C35661
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759537865; cv=none; b=k60l4xybi9AsuJlZwJI+J7CqE7ydjCGEfx9ZMBSZig4UOKUuxA+ooVu+hTsN9R2p3Kp7oZ95bYmt1aU1wuNuIPdZ9GKL85xfgBmAQtS92pP5NQ/JXUsoopESYw9KTSSlIkdaitPaF772F1re4M7QDE3aL7NAo4VskUZ8xRWChaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759537865; c=relaxed/simple;
	bh=rB5DFxYwYlqj5B2T0rCHndbBjUILgOapMgyrfi5lFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRO5qsUqkjKBPHkjI3x8yVdWXJgv5j34v6rLpFe4XDmD61pS2gLLziI3daTrSsZxNMZVi/rjmD1KdoXR+nBC8oT1jm6jZkK3eK0sPBK4zbOkmODl+FEvzc7XZXlZBEeRvB68hFvI2tUgqXqfrWxK5BJ8vB/Y2kwpYiZH9u7tIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL9NX17N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4880CC4CEF5;
	Sat,  4 Oct 2025 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759537865;
	bh=rB5DFxYwYlqj5B2T0rCHndbBjUILgOapMgyrfi5lFXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EL9NX17NAISOni2LABuSqYv70FCSAuQdyzrO097rHjyM+CIjSPCxqH75DL8FFwBml
	 EOZvVjV6VQ+ac2THlCoR27Jsx1v8ahXVCxxmIS3g0sDSBPP8B6uIDCktoLIdz2vVsI
	 1ujhPfTfhjWk756MSq1ExWRAHEJc6/58chMXhlZ/j/2dvQLvhMVdqtE5yziTnHryUf
	 ryLFyaXQQWAgUUejO56MpT3MwrAIwfa8nKmYj1ABkGAFZKslUuH7sdkKryjq6HnW46
	 /kkeaRZ/UcD1KmspNaMPcMOV7sIt0XyzyGVv817EFEBHYnzVw/8Tp5OFRl8Mvwb7eR
	 cAo8G4DNfkOAw==
Date: Fri, 3 Oct 2025 17:31:04 -0700
From: Kees Cook <kees@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: Please backport commit a40282dd3c48 ("gcc-plugins: Remove
 TODO_verify_il for GCC >= 16")
Message-ID: <202510031730.AC413A62@keescook>
References: <202510010810.7948CD9@keescook>
 <2025100338-produce-disagree-69f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100338-produce-disagree-69f2@gregkh>

On Fri, Oct 03, 2025 at 03:02:52PM +0200, Greg KH wrote:
> On Wed, Oct 01, 2025 at 08:10:58AM -0700, Kees Cook wrote:
> > Hi,
> > 
> > Please backport:
> > 
> >   commit a40282dd3c48 ("gcc-plugins: Remove TODO_verify_il for GCC >= 16")
> > 
> > to all stable kernel versions. This prepares the GCC plugins for the
> > coming GCC 16 release.
> 
> Now queued up for 6.1 and newer trees, it didn't apply to 5.15 and
> older.

Great; thank you! :)

-- 
Kees Cook

