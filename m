Return-Path: <stable+bounces-106778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A563A01EAF
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 05:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16EC1882510
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 04:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D13150994;
	Mon,  6 Jan 2025 04:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="XDL/7ttT"
X-Original-To: stable@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A73148314;
	Mon,  6 Jan 2025 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736139410; cv=none; b=HkUhpDIK1WNJn+NzYG/gZvUFLII34TFh/fLRZRr2AvAxjUnMavkOYq8T+HusVUmos+Ha+UCazuaSrv94slzRz/Qht8lMDyfab4mJ99oN1kKVaFhZBcgJbdss191IufNlVftHtaIoDYXBoJI1c21QQi0OObFupMgcwS8ZqIMMneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736139410; c=relaxed/simple;
	bh=uc7tqqF6YIVC0BpiNeb4gNwFWkk7DvylEEbXIu3HrHE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RIIISHwn2c3db7CrWGT8cWhO2txDUEixRtbze+xO7OBbM4tJt/ika3UUr0Dvz6cH/TxrQDwZWIWS7EmJN5MRl+I3nidMTcr3gQJUnlHj1ZP1lGzVuoCNJq+23z7IRgBD2fZW2ayP25iAaNh661QDaN/3OM35qpCltV72QiV7/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=XDL/7ttT; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mail.panix.com (mailbackend.panix.com [166.84.1.89])
	by mailbackend.panix.com (Postfix) with ESMTPA id 4YRMNJ0xCcz4608;
	Sun,  5 Jan 2025 23:56:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1736139408; bh=uc7tqqF6YIVC0BpiNeb4gNwFWkk7DvylEEbXIu3HrHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XDL/7ttTX9QJ4wj/BobiaCwW1cjGwASHb5vp/lrVSQJ3OivqPq84rWobxoAaEHaG6
	 +y26i/Jm4d9YqVQonJL5GQfRNZJON7nkV66jFA/57wn3cXu2Ngwz4+7ZId9fX+QVPW
	 vA5yG5u4yxs+B6SXeehG6Z8GE9blhoB2Hr98HNzg=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 05 Jan 2025 23:56:48 -0500
From: Pierre Asselin <pa@panix.com>
To: me@svmhdvn.name, alexdeucher@gmail.com
Cc: Xinhui.Pan@amd.com, stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Subject: Re: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
In-Reply-To: <4YRLq93qSpz1ZSy@panix2.panix.com>
References: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
 <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
 <4YRLq93qSpz1ZSy@panix2.panix.com>
Message-ID: <20d7e3ef9645b4440adfdbd83b0f33a1@panix.com>
X-Sender: pa@panix.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-05 23:31, Pierre Asselin wrote:
> Alex Deucher <alexdeucher@gmail.com> wrote:
>> Please file a ticket here:
>> https://gitlab.freedesktop.org/drm/amd/-/issues
>> and attach your full dmesg output and we'll take a look.

See https://gitlab.freedesktop.org/drm/amd/-/issues/3879 .

Sorry for the stray email earlier.
--PA

