Return-Path: <stable+bounces-230768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLkLEcVnx2lfWwUAu9opvQ
	(envelope-from <stable+bounces-230768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 06:31:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A334D68C
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 06:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F270630215FE
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1525336EDA;
	Sat, 28 Mar 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Lt84eSkv"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB9317715
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774675888; cv=none; b=TJk14UFkjD8Fm6qW2D8BE+bG5Zq58a4IU2jLKtEZqsXq8i0ThEoyjRcUXAN05P82JEuKB5DCkk7/40EmyJIME6yxw2wjIyvo2N4mnrm8GmqKigrSThnmI6trrSCCU747E/ETslGokODH23jN0XOoFd48Re/lNzI4/Z+msqV0yCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774675888; c=relaxed/simple;
	bh=kS3d2CRM/V2zCQ1rYhFkDFVyfOq/xAv1HYttLPL8+NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXJUHv65Nxk8up7rRmavZP+XnnjQ/t09fruoKidk+SyLmQori+y4U2p8WLrvFmF0iB6gE4A+NI3+c2SWl6DKlVtgOVH+jBh0EMoRNaNDkhB7djhB+r6Azuz9dbt2jYavT6qT5N8l8SozbkQ0hDhR517AolXAndCBqYujm8HlcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Lt84eSkv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-153.bstnma.fios.verizon.net [173.48.121.153])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62S5VFlV013532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 01:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774675878; bh=Uz/cqoX6DADKwB3OmZXIC+gCYepLUzkbnvAR1slNmDM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Lt84eSkvG4MNy7KXBRUMdB57ARue+JDnhYg15Dvdbwrrluz//iABeFMCAuvA6rvaA
	 EkP2O/q0l2N/R/LBHUmJyWTpZkCgUQc12UFPCaBBsA0f4zskPQSP21RXMZkYi/JWXn
	 VRVDiBqrSk6RlFAKz5d4fwgAxIUMtzpaJ/Fzw9VTKdleJ8U+KH8ukwehVFtJGk3FPn
	 V8FzdeRz9EEG0Izfb++6F5QOaU9T/zdsHBPPU96NzrBjr/mvKJXOhwadMih/0JEwEO
	 AlT8cV4QAScIbkbeFidJaYkbE7rdx+5PQNESI0EoWuwb4pbg/Cst9scTtbxPupa/42
	 P7GAnJJmcwgYg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F14502E00CE; Sat, 28 Mar 2026 01:31:14 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        yi1.lai@linux.intel.com, Mateusz Guzik <mjguzik@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix deadlock on inode reallocation
Date: Sat, 28 Mar 2026 01:31:05 -0400
Message-ID: <177467585138.1335526.8513595683008147724.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320090428.24899-2-jack@suse.cz>
References: <20260320090428.24899-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230768-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,linux.intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 400A334D68C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 10:04:29 +0100, Jan Kara wrote:
> Currently there is a race in ext4 when reallocating freed inode
> resulting in a deadlock:
> 
> Task1					Task2
> ext4_evict_inode()
>   handle = ext4_journal_start();
>   ...
>   if (IS_SYNC(inode))
>     handle->h_sync = 1;
>   ext4_free_inode()
> 					ext4_new_inode()
> 					  handle = ext4_journal_start()
> 					  finds the bit in inode bitmap
> 					    already clear
> 					  insert_inode_locked()
> 					    waits for inode to be
> 					      removed from the hash.
>   ext4_journal_stop(handle)
>     jbd2_journal_stop(handle)
>       jbd2_log_wait_commit(journal, tid);
>         - deadlocks waiting for transaction handle Task2 holds
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix deadlock on inode reallocation
      commit: 0c90eed1b95335eba4f546e6742a8e4503d79349

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

