Return-Path: <stable+bounces-142945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1170AAB079C
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201757A9E77
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621513CF9C;
	Fri,  9 May 2025 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6GnyfVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161213B58B
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755538; cv=none; b=HO2vpaC8b5LqBFyXCGujOg6+5Y2Zbtzu48co7Ox1bZnldeIy50nk2INJrsdc9y7IbcYop9OLqL5t61YWlApYetfholrZJMIUSU5GQ0rTka2g9ySdyUoqzJ8Epypd1TuRIb80tYDxcmAiztFOyRGjgZbTXpv35Z8MgEta7MKqn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755538; c=relaxed/simple;
	bh=Ss8xrYUTzSe+soIXG5H+SPF491LMdAUyMHVqeaEfW4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQAjoWWw4l+I04F03OXhdIsOuIQTsH5RYqx3HaissyyjCwO8HgnwS0I3EITW1Hcx4q/oPt1SPAzNtqsmXmdmxmE05N88AbkYnhemM02W8je/Z93mQHC40O8VcgNymSVzxsz+TX+GchOzm+eCI8qz1UJT1S2adwvGjP1cv4EH4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6GnyfVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1269BC4CEE7;
	Fri,  9 May 2025 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755537;
	bh=Ss8xrYUTzSe+soIXG5H+SPF491LMdAUyMHVqeaEfW4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6GnyfVbI7TcDCtEUptWm71o74gryfp6C02AI/uDWQ6anfUrTJ/HTkiGo67f5GYOy
	 kk7Aoa9JkDvg3/IMuUzXbzl4vJwWw7Q27mHHEFEh8DBkEm0nrtpXIi4W0DMvqgCOlf
	 10C5EpARpE9YUb93o9pmvXLNluJXylmuO0xoGPz6j611ILXK9FyBVuDBmmz6CNfuR1
	 HcEaYUFXRJ63OJNb5QUP53K02K66pIvxXrU7MO4CWRw4Avb/uJ1dp6oFa6qlBMP+RQ
	 THwYSgpUhKTvtkZmoWYKFvBQweRa0G0Lwqg7xrf+4t73YFyBYx4qOkzXhl6dNo0nbp
	 SqK5u2cmOVBOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] btrfs: always fallback to buffered write if the inode requires checksum
Date: Thu,  8 May 2025 21:52:14 -0400
Message-Id: <20250508132713-f223a8e53cd42002@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <968f19c5b1b7d5595423b0ac0020cc18dfed8cb5.1746665263.git.wqu@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  968f19c5b1b7d ! 1:  9ab4b4f9bed11 btrfs: always fallback to buffered write if the inode requires checksum
    @@ Metadata
      ## Commit message ##
         btrfs: always fallback to buffered write if the inode requires checksum
     
    +    commit 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 upstream.
    +
         [BUG]
         It is a long known bug that VM image on btrfs can lead to data csum
         mismatch, if the qemu is using direct-io for the image (this is commonly
    @@ Commit message
         filesystems have no extra checksum on data, the content change is not a
         problem at all.
     
    -    But the final write into the image file is handled by btrfs, which needs
    +    Bu the final write into the image file is handled by btrfs, which needs
         the content not to be modified during writeback, or the checksum will
         not match the data (checksum is calculated before submitting the bio).
     
    @@ Commit message
           to buffered IO.  At least by this, we avoid the more deadly false data
           checksum mismatch error.
     
    +    CC: stable@vger.kernel.org # 6.12+
         Suggested-by: Christoph Hellwig <hch@infradead.org>
         Reviewed-by: Filipe Manana <fdmanana@suse.com>
         Signed-off-by: Qu Wenruo <wqu@suse.com>
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

