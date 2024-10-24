Return-Path: <stable+bounces-88020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B524C9AE070
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770C428338F
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFB1B21AB;
	Thu, 24 Oct 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbkwcS0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB91AF0D4;
	Thu, 24 Oct 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761651; cv=none; b=jpiPIuifXi2n+UsFKjGU+i1f2OsXpIKl4PQLZc+fv/lq9qEa3lkFRevuPKrvVxfG5mkPQDKBQLqs9O73PwGIxGWRfNmNpx071wsHtcB/ZtEVl0Q2g+RuqbtspDfA/6DKl6tBlB9QpRecyfNwDJqNjZgWXtvSOO1NbDs2MmMayz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761651; c=relaxed/simple;
	bh=HdpD6kKSmeVYD15rxm/Hnloj0dAN0uXIGC2B4nAnC+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qhrNCyJ27BkTdNYF9Je57TDJ/1bf3R6nCv70Ma44+NnnGvNfsQgaRTyS71FULehR/o9ANT47ltngV3+imZMbJsffHzVW9Y5NdUPI6gqJu6gF86DVY7FLo2VJHKZ0kn3IAH3s82pqfJzyG/+jZJorrX+mxSbuw+A6gF8eCr/VsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbkwcS0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237D8C4CEC7;
	Thu, 24 Oct 2024 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729761650;
	bh=HdpD6kKSmeVYD15rxm/Hnloj0dAN0uXIGC2B4nAnC+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AbkwcS0RQqH9SgpiW3RWnuEI2VrlEqIibIwr7JQX9RkCjPMPqEaR7bVJw+swwoQhG
	 GDda2tJn3RQqsFLRCKfa3eRbpGS480A64J7mwIw3erGbSHRjJzEBEnhXkjhmP5OzPw
	 v67r/SvKHBOTXBD6NximFnPf36F/iEMZOt4lFsehkt5v9/titCOlnZ21ZmXnHQrl6P
	 48CDnyKd2PdeNwROmazkFyZDK/OB32w9gOK6JwoBAl1iKlws1d6UNILkzxkYKB8rfE
	 MxtP12WafuI+5pG6FifPpoZ0CLyZgbdO+QEOz9br/dQzNwOGl2jzhjJE6RHdY/IC9R
	 ity9+hQxuClFA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
 Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org, 
 "Lai, Yi" <yi1.lai@linux.intel.com>, linux-ide@vger.kernel.org
In-Reply-To: <20241023105540.1070012-2-cassel@kernel.org>
References: <20241023105540.1070012-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata: Set DID_TIME_OUT for commands that
 actually timed out
Message-Id: <172976164883.3801308.14901096680639262815.b4-ty@kernel.org>
Date: Thu, 24 Oct 2024 11:20:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 23 Oct 2024 12:55:41 +0200, Niklas Cassel wrote:
> When ata_qc_complete() schedules a command for EH using
> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> req->q->mq_ops->timeout() / scsi_timeout() being called.
> 
> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> handler), will set host byte to DID_TIME_OUT, and then call
> scsi_eh_scmd_add() to add the command to EH.
> 
> [...]

Applied to libata/linux.git (for-6.12-fixes), thanks!

[1/1] ata: libata: Set DID_TIME_OUT for commands that actually timed out
      https://git.kernel.org/libata/linux/c/8e59a2a5

Kind regards,
Niklas


