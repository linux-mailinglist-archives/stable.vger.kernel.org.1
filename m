Return-Path: <stable+bounces-124422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61BCA60D08
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 10:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69B218892F7
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889141DD877;
	Fri, 14 Mar 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uLdDn5oH"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502619F42D
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943954; cv=none; b=QUO7ZkzPkrXi6VZoeF8vw4Ym6J7TRKAI+aDqeUGlYBqpLmiU7Ut5nwU5ko7aWJ81o4QDDnFD57GTfypXMmMsM+SXs5LEhPf1/wwDiyFOT5PY+/6v8p0jw9+dQy5t5OCmDycBgAbUsd/hI3TYZSVmKDnr64cJ60+pNXzFViaKVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943954; c=relaxed/simple;
	bh=wNanv9d6zSE+k43FfZISbT58Xe27TDFaMeMOk2pj6oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9S1wrSA63HVNUh+EsXZe0iJAF67AMPTua+38dEUHc1mUXeiOznaJs8rjiK+2ifk3qe/FexM9FDkuEhjQZfUWMaHFGS4KsFpsCZBuNNCJNX9L2dRlQHcteIdZwHHSJi8mO6q+JQk8KBfFdKlJ+dW1eCW/JKvHsWm8LMufRR/vKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uLdDn5oH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741943950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsB/R6tuUISg4+cPSuM33uKTKKaJCD+JlDFZxLQ8IHY=;
	b=uLdDn5oH/wPSy11FX5E4aIWZJugYYgsRr118iDFFvsiOjsbUHDjs228Djl30Nox/K9yKpQ
	GEL6OTZ1v7wLFawdJzJS00RPpLTFaPgtnpZNp48JnC2aly66c8nB/23IhoQSkp2CheZIVz
	qWixsFQ8XMJWzKPVda6l3W9DVmhxZ+nqRvR+dNKBo3MAt6F7sPTSrJb+yhq/2NCpGXyb3K
	71zy6Y3o/M/U5P7as2ImwH5dG+//bohTgOxoKIiImEMiIpVhwnr2sOtd/OGylVzBXJmiiN
	rGuRt/nii9SpqjK34CmO4TxeObG3N87rgFtfiHU2nKfAGVzTeYySgzNlFJJHRQ==
Date: Fri, 14 Mar 2025 16:19:13 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <b39ca723-16a4-42a2-b8ca-b97d0e4bf7f5@manjaro.org>
 <2025031408-dividers-alphabet-d26c@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <2025031408-dividers-alphabet-d26c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 14/3/25 12:39, Greg Kroah-Hartman wrote:
> Can you bisect down to the offending commit?
> 
> And I think I saw kernelci hit this as well, but I don't have an answer
> for it...

The same kernel compiles fine with the older toolchain. No changes were 
made to config nor patch-set when we tried to recompile the 5.10.234 
kernel with the newer toolchain. 5.10.235 fails similar to 5.10.234 on 
the same toolchain.

So maybe a commit is missing, which is present in either 5.4 or 5.15 series.

-- 
Best, Philip

