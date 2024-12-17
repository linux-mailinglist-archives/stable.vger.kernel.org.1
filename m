Return-Path: <stable+bounces-104528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF089F50C4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE27AB636
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC91FA166;
	Tue, 17 Dec 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="avKBKsDB"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E81FA165
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451823; cv=pass; b=YM05tnBVAzLafWT0y1lnktNtLlnoGtcW0Wmx/bQT3SPCo5cmh2vATB2xfuUgtkrwXAzMITTiEEgqM92NcURluUnBr2ykdT7Y+KtIwiaKOCCzMaG0YPJuh/iAsdXVgMbseRG//fQdXCQ259oiX9cnc7/jGw3rfXxDT6f1LqdRh9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451823; c=relaxed/simple;
	bh=4Mu5gRgrK0KnKWP89qikPLvc95kC+RRyKQi5y4OTWCY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kleQf1u+nastkrK0DQ2d6nD35fZGNd/yiWH7pJLg3UX2qCjIUTUSDLBr3jaZg8860L1AQrGh5nP9WWB0czk+mxaFKEHUg7qjZ/1qohgl48bLc+MIOHn5WAGfSA9qm1ubZ8MfyH2eeuJjH9rJUoFwi/sGOIQXdBWejS8EobTMNMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=avKBKsDB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734451810; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dgO2HtyfPQY0AdgBBbzmlYw6gmCOMw6D2tknn1w2TqXLQyOf+o1oweFqGHTlM5o5N7ULUjJzLUFYgl5/8VlKr6MNcaLrIJPU4i5mRVDLY+u+pNl1oPxTqo278jhCQoEjVx/FF+FQdrDZHdlXDbYW2wt/w48qzk5IiH1mapyGGsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734451810; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2kEG0lBlvDEmER4Q9pWX+bnrm6qEcCyZcnhUEQqSrno=; 
	b=O4vvPsO5ab1PHA1RfgU2duLrEyljnZmKOLBzz96iSdvr2IvlfbDly9Tc1CmV/M8sQta9bQzjg60CbiVTxaSeh8ZQX3Jv3xabiaHDYdc5AZ6nZrolKtDxRxEqIAOQWjCgRGgoSAXROoeSc0Fu69nDy6i1DMLZh/dF01pXo1fN2vE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734451810;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2kEG0lBlvDEmER4Q9pWX+bnrm6qEcCyZcnhUEQqSrno=;
	b=avKBKsDBIJbWi2mw9ooBDddF4BxgsH2je/8Wk/FLYiLjXDPVYaydXyaXvQ6QXJnm
	Mi2AXOoCQKYAw/zbrXjJC8Dgzn53TaTpFC9+SVvccR+GM+Vdp6CzzaMPAQHu6B0L20c
	Pjek5gt1i40xUEjEBi4LTQgcTg25s0GjDQNznPWs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1734451807830184.69802839916838; Tue, 17 Dec 2024 08:10:07 -0800 (PST)
Date: Tue, 17 Dec 2024 13:10:07 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Sasha Levin" <sashal@kernel.org>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	"stable" <stable@vger.kernel.org>,
	"Engineering - Kernel" <kernel@collabora.com>,
	"Muhammad Usama Anjum" <usama.anjum@collabora.com>
Message-ID: <193d562463b.1195519191587461.735892529383555996@collabora.com>
In-Reply-To: <Z2GWCli0JpaRyTsp@lappy>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>
 <2024121731-famine-vacate-c548@gregkh>
 <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>
 <2024121700-spotless-alike-5455@gregkh> <Z2GWCli0JpaRyTsp@lappy>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



---- On Tue, 17 Dec 2024 12:17:30 -0300 Sasha Levin  wrote ---

 > On Tue, Dec 17, 2024 at 03:49:53PM +0100, Greg KH wrote: 
 > >On Tue, Dec 17, 2024 at 11:30:19AM -0300, Gustavo Padovan wrote: 
 > >> 
 > >> 
 > >> ---- On Tue, 17 Dec 2024 11:15:58 -0300 Greg KH  wrote --- 
 > >> 
 > >>  > On Tue, Dec 17, 2024 at 11:08:17AM -0300, Gustavo Padovan wrote: 
 > >>  > > Hey Greg, Sasha, 
 > >>  > > 
 > >>  > > 
 > >>  > > We are doing some work to further automate stable-rc testing, triage, validation and reporting of stable-rc branches in the new KernelCI system. As part of that, we want to start relying on the X-KernelTest-* mail header parameters, however there is no parameter with the git commit hash of the brach head. 
 > >>  > > 
 > >>  > > Today, there is only information about the tree and branch, but no tags or commits. Essentially, we want to parse the email headers and immediately be able to request results from the KernelCI Dashboard API passing the head commit being tested. 
 > >>  > > 
 > >>  > > Is it possible to add 'X-KernelTest-Commit'? 
 > >>  > 
 > >>  > Not really, no.  When I create the -rc branches, I apply them from 
 > >>  > quilt, push out the -rc branch, and then delete the branch locally, 
 > >>  > never to be seen again. 
 > >>  > 
 > >>  > That branch is ONLY for systems that can not handle a quilt series, as 
 > >>  > it gets rebased constantly and nothing there should ever be treated as 
 > >>  > stable at all. 
 > >>  > 
 > >>  > So my systems don't even have that git id around in order to reference 
 > >>  > it in an email, sorry.  Can't you all handle a quilt series? 
 > >> 
 > >> We have no support at all for quilt in KernelCI. The system pulls kernel 
 > >> branches frequently from all the configured trees and build and test them, 
 > >> so it does the same for stable-rc. 
 > >> 
 > >> Let me understand how quilt works before adding a more elaborated 
 > >> answer here as I never used it before. 
 > > 
 > >Ok, in digging, I think I can save off the git id, as I do have it right 
 > >_before_ I create the email.  If you don't do anything with quilt, I 
 > >can try to add it, but for some reason I thought kernelci was handling 
 > >quilt trees in the past.  Did this change? 
 >  
 > What if we provide the SHA1 of the stable-queue commit instead? This 
 > will allow us to rebuild the exact tree in question at any point in the 
 > future. 

Yeah, future-compatibility sounds better. As long as we have a git tree, a SHA1
and can match that to the test execution in KernelCI it works.

Is that SHA1 different from the one in the stable-rc release?




