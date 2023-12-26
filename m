Return-Path: <stable+bounces-8588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161E81EAB7
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 00:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5F61F21A09
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B7525D;
	Tue, 26 Dec 2023 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxHhC8N5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1E5662
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 23:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23244C433C8;
	Tue, 26 Dec 2023 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703631663;
	bh=LAMiKnNySP9qpZNfXN8F5WTWTEh2ObqDmHmBpuq4704=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxHhC8N5ARnw5sekGxrPKWXkdEs111Idf78LnM8l6blHh2IcHVc1ggOcdiJVhrnhc
	 A6l8C7FKLbm4I9Om+eSn5L6S8CyuVzJDcGNxrHeO0lMIcpP1E3a5btXUqTSYtIYDQE
	 VA8R237XFmE4MMQIbkwowwpaUznonuwP+W2VRAMIOTQl2ngQpTWiH6KB4lPS8oSdRv
	 LJiatKfFFiupS7iz5fK9arlnkkoqCZ6yckMs8jj4UPhnVfb7L7O+mGWZjSD/dAOT6q
	 y9Mz+m2iLAjhMJgIApVRtImsrkE0FWGFpNnMvzWLq/9rE5UExZo0cRhvnChBNJ6t0J
	 4Gj6kW0odvjFQ==
Date: Tue, 26 Dec 2023 18:01:01 -0500
From: Sasha Levin <sashal@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 5.15.y 1/8] ksmbd: add support for key exchange
Message-ID: <ZYtbLYw2xyQRG8Md@sashalap>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
 <20231226105333.5150-2-linkinjeon@kernel.org>
 <ZYrqaBw9o9L_WmW7@sashalap>
 <CAKYAXd-ujQ5-X4T7SeoUUoBVhhtqcdZujkcCoPrXu5245ORY2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKYAXd-ujQ5-X4T7SeoUUoBVhhtqcdZujkcCoPrXu5245ORY2w@mail.gmail.com>

On Wed, Dec 27, 2023 at 05:05:10AM +0900, Namjae Jeon wrote:
>2023-12-26 23:59 GMT+09:00, Sasha Levin <sashal@kernel.org>:
>> On Tue, Dec 26, 2023 at 07:53:26PM +0900, Namjae Jeon wrote:
>>>[ Upstream commit f9929ef6a2a55f03aac61248c6a3a987b8546f2a ]
>>>
>>>When mounting cifs client, can see the following warning message.
>>>
>>>CIFS: decode_ntlmssp_challenge: authentication has been weakened as server
>>>does not support key exchange
>>>
>>>To remove this warning message, Add support for key exchange feature to
>>>ksmbd. This patch decrypts 16-byte ciphertext value sent by the client
>>>using RC4 with session key. The decrypted value is the recovered secondary
>>>key that will use instead of the session key for signing and sealing.
>>>
>>>Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>>>Signed-off-by: Steve French <stfrench@microsoft.com>
>>>---
>>> fs/Kconfig | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/fs/Kconfig b/fs/Kconfig
>>>index a6313a969bc5..971339ecc1a2 100644
>>>--- a/fs/Kconfig
>>>+++ b/fs/Kconfig
>>>@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
>>>
>>> config SMBFS_COMMON
>>> 	tristate
>>>-	default y if CIFS=y
>>>-	default m if CIFS=m
>>>+	default y if CIFS=y || SMB_SERVER=y
>>>+	default m if CIFS=m || SMB_SERVER=m
>>>
>>> source "fs/coda/Kconfig"
>>> source "fs/afs/Kconfig"
>>
>> This looks really weird: the hunk above is in the original upstream
>> patch, but what happened to the rest of the upstream code?
>>
>> This change doesn't do what the message describing it says it does.
>There was a problem(omitted some changes) in the previous backport
>patch, I didn't know what to do, so I just sent a patch like this.
>Should I add it again after reverting the patch or just updating the
>patch description?

Given that this was due to an issue with the backport, I'd say just
write a new commit message explaining what happened, and point the fixes
tag to c5049d2d73b2 ("ksmbd: add support for key exchange")

-- 
Thanks,
Sasha

