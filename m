Return-Path: <stable+bounces-114394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18376A2D6D9
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E3718898DE
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710C248192;
	Sat,  8 Feb 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b="NPNk4Mul"
X-Original-To: stable@vger.kernel.org
Received: from greenhill.hpalace.com (greenhill.hpalace.com [192.155.80.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F14248178;
	Sat,  8 Feb 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.155.80.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739028342; cv=none; b=haj2jqN1mXNGSNQ+coDUvG9A+uALQ5NpUtA1Jx+Sx9B5yP8EEWf7YTXrBh2kvLZrQtL1aB7NG5lgM1pcBFPzaTRwREsED1m/hr3UaXp7RFu+dG/lO2caPrzgNzMYYmlw0Y9zsvbhHKr5ayAUACDz3OV2jo1d6paX+rEotTliidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739028342; c=relaxed/simple;
	bh=txcb17Dyd8K2FMh25wuAdjONKluBC/WDCjlReoHpCL8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:Message-ID:
	 Content-Type; b=NglKy7Q6ZxHzZdefFYC8GB/sf8tYMa3XdHu+IEjA18j9ORIaQeZIwiJInaPwB1LCxZKcv9DzzSNZOxVvGAY09Nbu2tKVsRTi8fKvMZbu5ib/59MiuLGNrOUyA/zND+uobS68mnMrILB7olrqQ2V2ShdXc/xdLNjhWYZdTh2JE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org; spf=pass smtp.mailfrom=finder.org; dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b=NPNk4Mul; arc=none smtp.client-ip=192.155.80.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finder.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finder.org; s=2018;
	t=1739027902; bh=txcb17Dyd8K2FMh25wuAdjONKluBC/WDCjlReoHpCL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NPNk4MulmCteIjGGVqtIaUMHMi1+ZqbMo9oafkQ2SY7n5g4dJQpDhpEBLVsFvtuQi
	 n53nwLSA0XldUQPDvTvjF8rpQbl2l6ZqcgIT0UQFIyXm1y2trFcKg2WpIMcdTutQAq
	 BnFnLfhgflFQfTnUu51NMD1n+gPv+N6MxuAu22LKQnOdy45rHWfQdY+cV9yLw7zjTi
	 t7SDwAJ+a5WvQB7bwdPhoZPooG7qdzSFxFPOpFVonbjcaPd1xXdI27Vl2BN+WnOiVa
	 DUEcMB5giERUUVtVThaufqxgopnN2Rgk3fbRZZ/YDoLfcpONfMpBoS5Pnodgj4LkBz
	 jCYi0ffZvjheA==
Received: from mail.finder.org (unknown [192.155.80.58])
	by greenhill.hpalace.com (Postfix) with ESMTPSA id 5D13D55A;
	Sat,  8 Feb 2025 15:18:22 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Feb 2025 07:18:22 -0800
From: Jared Finder <jared@finder.org>
To: kees@kernel.org
Cc: gnoack@google.com, gregkh@linuxfoundation.org, hanno@hboeck.de,
 jannh@google.com, jirislaby@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
In-Reply-To: <202501100850.5E4D0A5@keescook>
Message-ID: <cd83bd96b0b536dd96965329e282122c@finder.org>
X-Sender: jared@finder.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi, I'm the original reporter of this regression (noticed because it 
impacted GNU Emacs) and I'm wondering if there's any traction on 
creating an updated patch? This thread appears to have stalled out. I 
haven't seen any reply for three weeks.

   -- MJF

