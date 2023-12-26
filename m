Return-Path: <stable+bounces-8586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94D81E7E3
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109021C21E2E
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49F2230C;
	Tue, 26 Dec 2023 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGvi1VSQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F44CB55
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 14:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4AC433C7;
	Tue, 26 Dec 2023 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703602794;
	bh=oQGfQNCR3ZYUsNLoM6ycJq7TUrIo6qXpNRsBHh9gS+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGvi1VSQQX94j2a8jiv9s+0fZWqgzZwidMrj19cKNVZNopkc89kh8BbUpQ9zqAxeC
	 dU2+MPD+0hWy0QAU/pfoDagW9jT99Y9Xe1tqwa6LXBQQVRuJqie439BlnHDr4Isu12
	 23tv7ELztKqqkUKt0o3Nqtv35H1CylfJtSNjaB9hDyl38xDrDrpaM7P25yeaWdu3eZ
	 aKKVkpnHINA7DVUUMOcE8s1mOM1kg2qmnkmCBR0/vu/euv67u/Wf+WARSWJBzqRP0E
	 SiR85Y3PeY26c+nfSzNsZBAXczhHwPm0JsBRCaOE6IK8nRejoZtdqHpLrztHQREMif
	 0qLgO6OiJP4aA==
Date: Tue, 26 Dec 2023 09:59:52 -0500
From: Sasha Levin <sashal@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 5.15.y 1/8] ksmbd: add support for key exchange
Message-ID: <ZYrqaBw9o9L_WmW7@sashalap>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
 <20231226105333.5150-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231226105333.5150-2-linkinjeon@kernel.org>

On Tue, Dec 26, 2023 at 07:53:26PM +0900, Namjae Jeon wrote:
>[ Upstream commit f9929ef6a2a55f03aac61248c6a3a987b8546f2a ]
>
>When mounting cifs client, can see the following warning message.
>
>CIFS: decode_ntlmssp_challenge: authentication has been weakened as server
>does not support key exchange
>
>To remove this warning message, Add support for key exchange feature to
>ksmbd. This patch decrypts 16-byte ciphertext value sent by the client
>using RC4 with session key. The decrypted value is the recovered secondary
>key that will use instead of the session key for signing and sealing.
>
>Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>Signed-off-by: Steve French <stfrench@microsoft.com>
>---
> fs/Kconfig | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/fs/Kconfig b/fs/Kconfig
>index a6313a969bc5..971339ecc1a2 100644
>--- a/fs/Kconfig
>+++ b/fs/Kconfig
>@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
>
> config SMBFS_COMMON
> 	tristate
>-	default y if CIFS=y
>-	default m if CIFS=m
>+	default y if CIFS=y || SMB_SERVER=y
>+	default m if CIFS=m || SMB_SERVER=m
>
> source "fs/coda/Kconfig"
> source "fs/afs/Kconfig"

This looks really weird: the hunk above is in the original upstream
patch, but what happened to the rest of the upstream code?

This change doesn't do what the message describing it says it does.

-- 
Thanks,
Sasha

