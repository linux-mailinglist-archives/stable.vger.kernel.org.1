Return-Path: <stable+bounces-194894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61268C61FA3
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BACDD35AFEF
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43C1DA0E1;
	Mon, 17 Nov 2025 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzyGTOWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881951A239A;
	Mon, 17 Nov 2025 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763341605; cv=none; b=GeWi6McpHtYkn6SILWa4Gh8TzB8efzYVQydyM50pMkiebyAJaArBBvyDlCoVxtDcAuzTHXfmwO3fCd2EdwPpcacJ2ptsD+TPBiBUlZHtGayyDz6gQ+Qz0DQdLWG890TsdQYivoj06324EAYk2bmd9at0ircsoOxv72XomV/loIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763341605; c=relaxed/simple;
	bh=xddr9BcInPYiHAAu8+Jh5kbEV9uKQTSfl8UR+7osxa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY45HAfkGtK07qcVmp/isrG34WeK3fDU8E6GtPlq6LOWgboeASvUHqM7wk2QUZKA/LH76WYhSmKl4+IImDUbZX1GP/BPZGQ50Co4AxDGnriNbTWedpyq+kwMv5Mw39GFAX+y0xPVZyxUw51aQlaYq+c7bLCCBgtsZZrbO+6D18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzyGTOWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74763C113D0;
	Mon, 17 Nov 2025 01:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763341605;
	bh=xddr9BcInPYiHAAu8+Jh5kbEV9uKQTSfl8UR+7osxa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzyGTOWEQzSuQtJGPDslKSJiK8f4g4+AOzhsSdvmV/iU9S/XqBn3EWoe4ef65iodm
	 8DmgUjvD4koh42tVlKOwTp2Ti57mtNpByHt/DuwymLQXG0BSdchhZ5+OgRQwrO5cdG
	 mCOEL6OTF3i6JT1gAk/o1JGn/76TfvaGseUEXtZsTUHsV0pvzCMJB3YIOoJae92hpG
	 ucVVxoqTAXqszyI3pMNNQzVB46EzTtMpqrmnuYHnMXeS35VH/E/VeRTDsFRL49qlz3
	 U4gs4L/owMWz/s6YgvS5JSbsCcTToXUTi9kJ54D04BHdmDilM7LXIN0DAvdAWLc7ef
	 y5nYf7cz6C+gg==
From: Sasha Levin <sashal@kernel.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: jstultz@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tglx@linutronix.de,
	clingutla@codeaurora.org,
	mingo@kernel.org,
	sashal@kernel.org,
	boqun.feng@gmail.com,
	gregkh@linuxfoundation.org,
	ryotkkr98@gmail.com,
	kprateek.nayak@amd.com,
	elavila@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 6.1] softirq: Add trace points for tasklet entry/exit
Date: Sun, 16 Nov 2025 20:06:42 -0500
Message-ID: <20251117010642.3740129-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112031620.121107-1-sumanth.gavini@yahoo.com>
References: <20251112031620.121107-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: softirq: Add trace points for tasklet entry/exit

Thanks!

