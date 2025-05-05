Return-Path: <stable+bounces-139712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D9AA9710
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9813A3A6491
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497F25C83C;
	Mon,  5 May 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlWUjCKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B564C85
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458038; cv=none; b=GiBuXtNnlfJnJdvQ4s4a256YnYc5wWAP9l5rQEW+FNNOba/mHZsqtwqNnNc26adMhhqu803UWLo2ncuklGcSaoPF7yM5yKBcpNLUFtJwSyWvCG3yTWwhAikWD/5FZmAp2do2XH43TMr2ozQgkWwk+26GDLKBcaYdcqbmGDsQbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458038; c=relaxed/simple;
	bh=7gJSXHZ7rXnwOQwtGPP3RUPU7DzszefNWRtS+xyl0+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUb6F1eXtIpGb8B3X5OIT8Qk+PdRgYQPWTa/AlRgjUygItkyoIAMY2vJ+lxRUQhV/g78JOaWUwRbWuRQrXizzwVK6ACePjuN05yhOlYmRdE65vqkF9O5DBmA0tsJzX4bWaBKEycmlboOxvbG0n6ntDTiGMCMqxygVPg0nQjRKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlWUjCKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8781FC4CEE4;
	Mon,  5 May 2025 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458038;
	bh=7gJSXHZ7rXnwOQwtGPP3RUPU7DzszefNWRtS+xyl0+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlWUjCKjQKWZBC8eYeqlhE1HxiKYJj+SOONc6rufIbCn8bylGusNhVxaznNkfQGTH
	 MhkJ+NkF9rNu567RIX1Wbs5HqaWvYOyDTnrrGaJ6PMEd5U+JZ9K8zdRjGk7AY6YG/l
	 IfLMOoJn6l3/GFxAcsIRHG2J2urut7PFftyfYnUsJV1wHG3upaXVqA5OxO+bGxny49
	 yX/6bOaDAnnDg/Tc9FQ3pQTVnD95WYxZMuz7nTom4v3rZCrBlS7xdMTxkoEcb6R/15
	 /VqFg/Fph1YK4hxw4YlNlPyMrMZkPIzDVkt7RAQN5hrT3aXeWmcKRIRiWydwKVtiRX
	 lQV2jglbLH19g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] smb: client: fix double free of TCP_Server_Info::hostname
Date: Mon,  5 May 2025 11:13:55 -0400
Message-Id: <20250505074437-2be4ff98f8f823c8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250503175819.2818701-1-Pavel.Paklov@cyberprotect.ru>
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

The upstream commit SHA1 provided is correct: fa2f9906a7b333ba757a7dbae0713d8a5396186e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pavel Paklov<Pavel.Paklov@cyberprotect.ru>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: a2be5f2ba34d)
6.6.y | Present (different SHA1: 1ea680703385)

Note: The patch differs from the upstream commit:
---
1:  fa2f9906a7b33 ! 1:  56e7a9b9b42bb smb: client: fix double free of TCP_Server_Info::hostname
    @@
      ## Metadata ##
    -Author: Paulo Alcantara <pc@manguebit.com>
    +Author: Pavel Paklov <pavel.paklov@cyberprotect.ru>
     
      ## Commit message ##
         smb: client: fix double free of TCP_Server_Info::hostname
     
    +    From: Paulo Alcantara <pc@manguebit.com>
    +
    +    commit fa2f9906a7b333ba757a7dbae0713d8a5396186e upstream
    +
         When shutting down the server in cifs_put_tcp_session(), cifsd thread
         might be reconnecting to multiple DFS targets before it realizes it
         should exit the loop, so @server->hostname can't be freed as long as
    @@ Commit message
         Reported-by: Jay Shin <jaeshin@redhat.com>
         Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    Signed-off-by: Pavel Paklov <pavel.paklov@cyberprotect.ru>
     
      ## fs/smb/client/connect.c ##
    -@@ fs/smb/client/connect.c: clean_demultiplex_info(struct TCP_Server_Info *server)
    - 	/* Release netns reference for this server. */
    - 	put_net(cifs_net_ns(server));
    +@@ fs/smb/client/connect.c: static void clean_demultiplex_info(struct TCP_Server_Info *server)
    + 	kfree(server->origin_fullpath);
      	kfree(server->leaf_fullpath);
    + #endif
     +	kfree(server->hostname);
      	kfree(server);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

