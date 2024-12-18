Return-Path: <stable+bounces-105243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3269F6FCE
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777DF188985F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100921FC10E;
	Wed, 18 Dec 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4PQTt3o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1E154BE2
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559183; cv=none; b=nAC55t3ZKXJCkiB372wTxOUjreoQG52hO7wFjw/mq1ocGTfJc2wkx/TzZTpa+KWVLkFQ/nUVBfRL7BsIFnVBuHTizvWkj9xIXuD1ULPk6GVMy3hEmUE+HJqhSN2SY3Yd4Fkp9E8TjlaaF8hn5mcB/Zr9Se70Q2Ya/CFKLrcBQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559183; c=relaxed/simple;
	bh=VVzFIMrU+QsZLY7oZ3CyZdypmx+lKyTlkmTXnvIeF6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj4kJSuzM2bD3Y8pC83qqD/XYM/G6If+qQb49mOFYANN80vuw/ykHFmzJq0uY3CcuExgNtap5hNs7ldh/E/VBOpT+It8BJUCHMfoC2tVq6tQzVAN0hmEHjujHCF8cu786rkkZHDUPuokSDQS7KBAYz9m1vZJLC0EXF1k/5Ka+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4PQTt3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A16AC4CECD;
	Wed, 18 Dec 2024 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734559183;
	bh=VVzFIMrU+QsZLY7oZ3CyZdypmx+lKyTlkmTXnvIeF6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4PQTt3osPb8/VttmF6WLdgjUpACB+rnlyBkDjAiCXuge//5H9TjS7sNHIWq9DQMO
	 DbMyDr0WizMYyzgyfkOd3lIXEt9wMDqHdbVvbhw8FTDWkT9dmP7DYUzWXCMokKwe57
	 IAnCjZyJXP9sF98f1Kju3MYVRQIivwTXeAGULoL7+9KkEpELAoMkNzAoOJjdeqXgvi
	 SBot6BitDZ8eW9TWvecQ6FFaHVhVGllM97o9BUTiQRRFKZxWBQx+n8x4brQAXrbEOV
	 8XWS5qubKOqP32qXAbWt+yuBM2pzhWIVS+sl6VzAi2x95DfUL5w5Sqzb6vs9ilj3e7
	 yEH5djlQpV1qw==
Date: Wed, 18 Dec 2024 16:59:41 -0500
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@amd.com>
Subject: Re: [PATCH v2] mailbox: zynqmp: setup IPI for each valid child node
Message-ID: <Z2NFzb2byhmiDVtf@lappy>
References: <20241216214257.3924162-1-tanmay.shah@amd.com>
 <20241216192841-922fe76161366e54@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241216192841-922fe76161366e54@stable.kernel.org>

On Mon, Dec 16, 2024 at 07:42:17PM -0500, Sasha Levin wrote:
>[ Sasha's backport helper bot ]
>
>Hi,
>
>Found matching upstream commit: 98fc87fe2937db5a4948c553f69b5a3cc94c230a
>
>
>Status in newer kernel trees:
>6.12.y | Not found
>
>Note: The patch differs from the upstream commit:
>---
>1:  98fc87fe2937 ! 1:  7d2de1d13592 mailbox: zynqmp: setup IPI for each valid child node
>    @@ Commit message
>         Fix this crash by registering IPI setup function for each available child
>         node.
>
>    +    Cc: stable@vger.kernel.org
>    +    Fixes: 41bcf30100c5 (mailbox: zynqmp: Move buffered IPI setup)
>         Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>    -    Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>    +    Reviewed-by: Michal Simek <michal.simek@amd.com>

Why did we lose a S-O-B line here?

-- 
Thanks,
Sasha

