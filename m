Return-Path: <stable+bounces-125801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906EA6C771
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8734637C0
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4292C147C9B;
	Sat, 22 Mar 2025 03:36:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CF13A265
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614603; cv=none; b=b5xkNlhg9PQoAOPpW9DJOT+bV0Q+JSW5RITlTCv5dTyzX1YLns5e0xnPA3cQpSBANYtQwuJIjNoXpAFRDtYv6KfLnDtC+56uUm1GNql9hwc1Av2hYG+o5OkoL5zW36sxFJoumHbfcHhDVcUNFO+7y5yFn2CD9VDwsaueXF14i48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614603; c=relaxed/simple;
	bh=RzWxGX0gt0H7R6LSshfnsfipRDDjCoPVTdnFp0GcqTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHHqjfZA5Z8GHHMopnWXuv8XxG3k+JTYrY0ZWkhwp26TN6XhU0H5duETCpjjSoQsA4xTY7eY8qJdgUFIGhHTdce09vBFs3HCFndeE6fk1jo0keN2PzWzf8JBdXAN5nKKnBbZS0NIqh0p2/XS8OPRMbIb/Su9tTIxREecydCmduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMaA007710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B6F972E010B; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Acs, Jakub" <acsjakub@amazon.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, acsjakub@amazon.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH v2] ext4: fix OOB read when checking dotdot dir
Date: Fri, 21 Mar 2025 23:36:14 -0400
Message-ID: <174261457018.1344301.17270350351088330714.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <b3ae36a6794c4a01944c7d70b403db5b@amazon.de>
References: <b3ae36a6794c4a01944c7d70b403db5b@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Mar 2025 15:46:49 +0000, Acs, Jakub wrote:
> Mounting a corrupted filesystem with directory which contains '.' dir
> entry with rec_len == block size results in out-of-bounds read (later
> on, when the corrupted directory is removed).
> 
> ext4_empty_dir() assumes every ext4 directory contains at least '.'
> and '..' as directory entries in the first data block. It first loads
> the '.' dir entry, performs sanity checks by calling ext4_check_dir_entry()
> and then uses its rec_len member to compute the location of '..' dir
> entry (in ext4_next_entry). It assumes the '..' dir entry fits into the
> same data block.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix OOB read when checking dotdot dir
      commit: d5e206778e96e8667d3bde695ad372c296dc9353

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

