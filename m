Return-Path: <stable+bounces-55820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD69178E1
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 08:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28B3B2104E
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FE14D6E0;
	Wed, 26 Jun 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIfBc5qM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935A13A869;
	Wed, 26 Jun 2024 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383234; cv=none; b=qpSzpZF/vP2qYSIv6s8fgG2zXgr1t4zFbGoR0SDpvwG9kEQ2HUlMsAYMsttz9mtr3WQsPegqSZgC8haod7h2Ae8YVnHG/RGxjDgiR+sop6GjEisv4s0R2Gv3CcA/1cTPs2XCprhkmp2W/Z2jV35lEqcaF0X6Ra4fmKc5r4BQEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383234; c=relaxed/simple;
	bh=Wm196pXLUQHFQCqItQXnYagVg0YydCq+YjZPRlY5sD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRwElJuz4BqUtht/R+VQjv7c85zamnKwEGOQVy5Z5gcv6Lrahz6sTtrsW/rmivrZR2CR4LI2pS3xACfMePeZiJdGcdPNkYrzRq9lX+5HpVAWdfyhnr/sBiIqmShg3hEUr2HYp5yPcfK0TueJYyed9YtzcJ1LZMcfzgWJnOkn6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIfBc5qM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D681C2BD10;
	Wed, 26 Jun 2024 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719383233;
	bh=Wm196pXLUQHFQCqItQXnYagVg0YydCq+YjZPRlY5sD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pIfBc5qMVVdqj+MTTPDDw3ZriOh9KuvxBava1VwqzenOjhV1ZDa90KenbbmbgKyCR
	 DoTp8Qe42TmqYiMjBaQv7T3QcZmlHSHipKlQM/lROi85O8CKY/Uf5O7/0hYmucHohu
	 ipwm3riIQBNXafp0B36qs5ekQ2mGn4xM9/osGiPDa0n9s1edBvyOZSENhzjNa7DUPX
	 f9i6F6mc75M2mg5UVZnJ+zMMqUUjgdORIaMlOtGesdxWBdLPTog+JL6bt1glOZch5E
	 kxYQ8oKzhpVnlMJpy6Oq9Zz8qaEAkSGa9N1c3tG2l6knjyedCXacqni4pWh7sL2cxF
	 rD/c/cCrpU/GA==
Message-ID: <ad1ced48-4c17-4fe0-b75f-21bb9486f1ac@kernel.org>
Date: Wed, 26 Jun 2024 15:27:11 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-2-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240624221211.2593736-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 07:12, Igor Pylypiv wrote:
> Current ata_gen_passthru_sense() code performs two actions:
> 1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
> 2. Populates "ATA Status Return sense data descriptor" / "Fixed format
>    sense data" with ATA taskfile fields.
> 
> The problem is that #1 generates sense data even when a valid sense data
> is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
> a separate function allows us to generate sense data only when there is
> no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).
> 
> As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
> which states that we don't want to translate taskfile registers into
> sense descriptors for ATAPI.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


