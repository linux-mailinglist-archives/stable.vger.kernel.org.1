Return-Path: <stable+bounces-145053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECAABD594
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 12:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE5167BAD
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565A26A1D0;
	Tue, 20 May 2025 10:51:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02926A0F6
	for <stable@vger.kernel.org>; Tue, 20 May 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738308; cv=none; b=NMvy7RbaoaQlnfRgt8l1xiMitSYVne1rrd0rbk6DUP8bL2lRC46+tce7gpbUGyqL2pf/KF0N1EyuohMv6S0S9CsEUAWs7xtOXW19+TEhljBgC43m4MODAP0V4gD87KjiO6RJaaGLoERlQUZRlgyl4RX4002nEnjYKiM6288GsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738308; c=relaxed/simple;
	bh=Qx0AqF0InTLVtJJEHoTiVZDdhrkNjEMOmWN/Lfdc/us=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GbVGe1r+zFp586YXQInrVZwERxZl3kzKZE5z/ggDfXBZNYX0XTlWJVDjV9Lcefbg5XKztDHL4+E37t+LW82GAsWRjFHN7Mh4ntjXlquD6evxniuVNjB++UxuXXCsbktjLxDQrPDkt8T9Wx92r8W2aFATBLA7rtywaDRkQNuvzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b2e8559.dip0.t-ipconnect.de [91.46.133.89])
	by mail.itouring.de (Postfix) with ESMTPSA id CFC1D1098;
	Tue, 20 May 2025 12:51:35 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 97B776018BE80;
	Tue, 20 May 2025 12:51:35 +0200 (CEST)
Subject: Re: 6.12.29: amdgpu-related "fail"-messages during boot; bisected
To: Rainer Fiebig <jrf@mailbox.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <e5faa1de-6a41-5259-6f69-66ff875ed9bf@mailbox.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <b39eaafb-2984-56cd-c84d-ed457256a190@applied-asynchrony.com>
Date: Tue, 20 May 2025 12:51:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e5faa1de-6a41-5259-6f69-66ff875ed9bf@mailbox.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2025-05-20 12:34, Rainer Fiebig wrote:
> Hi! After updating to linux-6.12.29, I see lots of "fail"-messages
> during boot:
> 
> May 19 23:39:09 LUX kernel: [    4.819552] amdgpu 0000:30:00.0: amdgpu:
> [drm] amdgpu: DP AUX transfer fail:4

The fix "drm/amd/display: Avoid flooding unnecessary info messages" [1]
is already queued up for the next -stable cycle.

cheers
Holger

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d33724ffb743d3d2698bd969e29253ae0cff9739


