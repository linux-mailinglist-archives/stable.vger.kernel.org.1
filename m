Return-Path: <stable+bounces-134711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A507A9435F
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 14:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F2E4403F7
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042F18FDBD;
	Sat, 19 Apr 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3fPk2u8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91D259C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745065171; cv=none; b=OE8QcxojZX1qSQyjkGg34X/McizUpZBVreE2x8TUzZGoNZPG5nJd06u3qCbwqXmR7hgkFgXAT1BxG6xuzf4Q1e8G6zxPLn4REMosFVE7S7OLU03PQrzIh05XBt3BxK9Jga7XI0Md75v8bE3jBQHb+eCRmXqYf7LCLihQDfGpAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745065171; c=relaxed/simple;
	bh=4Cx1y8P1CsfLCXI4hkkaNkpMiJ7q3mLOy54LT71ftLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lc9z6Kqu8p/SKB29oE2K4D7Q4xB/sdPh039pbIn6qtAx4zeF7f/OyhFllvwJZt+or4/RYNSlWhSWS45e0AULzSoNEY1Ifc9PuaOdKUlMlf9hRUrcdIKNYBi1hVPuxAD2F+myqjeyl/Rv6z1d8DXn7Gl4GD9BhEEOPG0ITTqbYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3fPk2u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C72C4CEE7;
	Sat, 19 Apr 2025 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745065170;
	bh=4Cx1y8P1CsfLCXI4hkkaNkpMiJ7q3mLOy54LT71ftLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3fPk2u8SX+143f8F9JfGUvbV4aat1IvblncVKn+l7QLTxi/dQ2HZLnmjcDHZgNyi
	 Db1Oa9WW3SF+a6m9tMwQjkuSLW45pp00xyBVtggOs3IY1HjUlg7YAr0NkijzSIr2kZ
	 oVfxa5P/uDL5thNN69GZMbnXp2P+qBX82lSFuRBxb4VlX70xxfS57tdrD6K9BJPJKy
	 jwmaZWflAMJH/DoenajQZ3GZv+qXBDuO5R9PkFGvnQyg8s3LzgHQMpzcAbCI3HelMm
	 eXXG5IxTuznCkSRAHUVOWPCdD7QtdEEY+hd0rqL6Df2N+qyHsOB1xC5I57gekTk8Oj
	 mDBbkzgtdAHgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Sat, 19 Apr 2025 08:19:28 -0400
Message-Id: <20250419080107-89321e12c31f275e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250419084059.53070-1-miguelgarciaroman8@gmail.com>
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

The upstream commit SHA1 provided is correct: 985b67cd86392310d9e9326de941c22fc9340eec

WARNING: Author mismatch between patch and upstream commit:
Backport author: <miguelgarciaroman8@gmail.com>
Commit author: Lizhi Xu<lizhi.xu@windriver.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  985b67cd86392 ! 1:  18c15fd3e33df ext4: filesystems without casefold feature cannot be mounted with siphash
    @@ Metadata
      ## Commit message ##
         ext4: filesystems without casefold feature cannot be mounted with siphash
     
    +    commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.
    +
    +    This patch is a backport.
    +
         When mounting the ext4 filesystem, if the default hash version is set to
         DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
     
    -    Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
    +    Reported-by: syzbot+9177d065333561cd6fd0@syzkaller.appspotmail.com
    +    Bug: https://syzkaller.appspot.com/bug?extid=9177d065333561cd6fd0
         Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
         Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
         Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    +    Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
    +    (cherry picked from commit 985b67cd86392310d9e9326de941c22fc9340eec)
     
      ## fs/ext4/super.c ##
     @@ fs/ext4/super.c: int ext4_feature_set_ok(struct super_block *sb, int readonly)
    - 			 "mounted without CONFIG_UNICODE");
      		return 0;
      	}
    + #endif
     +	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
     +	    !ext4_has_feature_casefold(sb)) {
     +		ext4_msg(sb, KERN_ERR,
    -+			 "Filesystem without casefold feature cannot be "
    -+			 "mounted with siphash");
    ++			 "Filesystem without casefold feature cannot be mounted with siphash");
     +		return 0;
     +	}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

