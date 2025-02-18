Return-Path: <stable+bounces-116787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE82A39EA4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599C71668A0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780E269D1E;
	Tue, 18 Feb 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTF4JWpZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A11267F4C
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888490; cv=none; b=RNP2Fmd/yPTyCU3VoTanlOqxkDLlY4PdU7hxtbxNfiAuuWLwAfrKow3562Ivt1q7HWFXHglwTJtSOVeKfmUP/aIqk2CR59PSzaULHMlD0AbN6bftHUJQGWdMCvP3I7/LL6kAjcvWJDti30LVAaQUrxVuKiTObKo9g7aZUCQjenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888490; c=relaxed/simple;
	bh=cmsBfIUEh3VBPhYiGxydZw1UWXGXm/IXGnbC37PbqbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvrOv6/7Y7MGBbvPPPFZ+uJ1qvZ5zJ2Pih7y4DSkTaTvucPNf+eOd1GlV5WAfaKRNoXZAqvmlGID23PzyBjTwUWRGWp+ND1Pk0KRg9k8/ByNmjc5suzrLtnGM6SqjEl94IawkMqLQW7eHsUL+To7rhrHlf6B6J7SfeZtUu7sEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTF4JWpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0E0C4CEE2;
	Tue, 18 Feb 2025 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739888489;
	bh=cmsBfIUEh3VBPhYiGxydZw1UWXGXm/IXGnbC37PbqbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTF4JWpZRwkjlV0O2DopmSw4wrazMlXMnL9rzXrr8BnGFcCwBlDn5qiU4wY9MumDc
	 kr0Zny2DIWXZyZHkTIHo/YMLnHVSlEnY+D/kZlwBylEHUx9b4jquqLItV8igQh0KVn
	 SiuYaAzt4upcJeyQFYwhlvI8/L8Xi5TGss551UUIAzvYl/KzTlVKcC53Jl2UNTxS9g
	 XQTruLpwKbUuy54gg9V8qu3feoZ25u8QrGpUz1/ohHvqehc00r5TeDdbhDbxTsks9s
	 c0uujcP1DNGUyRu81ZfKjSIUb2tdNvj7OykaE2klkx6Fmrs3a7e/oIz0nJtv5CxL0b
	 JOVzAEQJCJVbg==
Date: Tue, 18 Feb 2025 06:21:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <gregkh@linuxfoundation.org>
Cc: pabeni@redhat.com, edumazet@google.com, <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] Revert "net: skb: introduce and use a
 single page frag cache"" failed to apply to 6.13-stable tree
Message-ID: <20250218062128.12823bb7@kernel.org>
In-Reply-To: <2025021858-cobalt-scanner-666f@gregkh>
References: <2025021858-cobalt-scanner-666f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:01:58 +0100 gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.13-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
> git checkout FETCH_HEAD
> git cherry-pick -x 011b0335903832facca86cd8ed05d7d8d94c9c76
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021858-cobalt-scanner-666f@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

This got re-reverted / reapplied as 0892b840318d.
There were some warnings discovered, the commit will come back once
those are addressed.

