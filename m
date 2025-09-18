Return-Path: <stable+bounces-180543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F115AB85490
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB933174F7C
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75B305E28;
	Thu, 18 Sep 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouruKKqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1F1898E9;
	Thu, 18 Sep 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205954; cv=none; b=Q1XK6zMWpR1uqJn4o2huU/+qHXu35ATM0hwIsYbNE63FYyM5H5rfO+PlpYXBFf2yX9kV0WCql4SpdFs8Hjw9Y6+rOQ8HYF78YmdISBKYN4ANfbZX2dMgCMzk6b9+BQi5D824C1C5rtORuvTC0Y3RuagwuLkO8p9AYVSzp2ochdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205954; c=relaxed/simple;
	bh=iaW1UOTqyyrP6yyR6u+Tx9vOZm6cbBQdMx5S77Us3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6D7STsSQKA5o28ilY36eMwSU0XjJQEzdPJMlDqzqoM8sTIEqyVrSZpvxz4KR6DRDiNdTrHHhONOWwFg3dpkC5xGcpQhP6bM/QBgnJuGLVEaV0Fz6ik1UyFXfq/o/hFb8pjkI73Y/ST1Xc0M/yw/0AdEzuEXu5wAf0NIOgfquAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouruKKqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF111C4CEE7;
	Thu, 18 Sep 2025 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758205954;
	bh=iaW1UOTqyyrP6yyR6u+Tx9vOZm6cbBQdMx5S77Us3dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ouruKKqctMnxgh4y95bBYlhCSFfhrBEBYErPJT0a1q8ArrbYX/ptH0AvuPW5l5YpQ
	 LyCp5Q3Q9171Vzd8wRx2ECZpWzpi5LkkogHVRa43Vsk8QZXZRthD8lGhbfBTTczrMr
	 2P5pZPadY9d/7hQfH8+PRdHESSkuqZuATMpxTqEDH3ubIK/o9hcsM0epH9aAldIvJ/
	 kC0By+T8AMP21X1F43gOBismc+nykfXcON9CF36ab4sz7XHOrWnWllQJAMJ6pCh3jH
	 bLIeqh3vpHYAc8bZIuXwSp/UpY5hkPV2JvJaMoDekjJi9on22eYdZezalhhFyOZi1a
	 qQ4GJe85uLYyQ==
Date: Thu, 18 Sep 2025 07:32:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: fix overflow in
 octeon_init_instr_queue()
Message-ID: <20250918073232.6137a819@kernel.org>
In-Reply-To: <20250917153105.562563-1-sdl@nppct.ru>
References: <20250917153105.562563-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 15:30:58 +0000 Alexey Nepomnyashih wrote:
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

No ads in the commit messages, please. Put the company / project in 
the From line in the future. Quoting documentation:

  From Line
  ^^^^^^^^^
  
  The ``from`` line must be the very first line in the message body,
  and has the form:
  
          From: Patch Author <author@example.com>
  
  The ``from`` line specifies who will be credited as the author of the
  patch in the permanent changelog.  If the ``from`` line is missing,
  then the ``From:`` line from the email header will be used to determine
  the patch author in the changelog.
  
  The author may indicate their affiliation or the sponsor of the work
  by adding the name of an organization to the ``from`` and ``SoB`` lines,
  e.g.:
  
  	From: Patch Author (Company) <author@example.com>
 
See: https://www.kernel.org/doc/html/next/process/submitting-patches.html#the-canonical-patch-format

