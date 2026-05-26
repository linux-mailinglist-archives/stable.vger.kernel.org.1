Return-Path: <stable+bounces-254371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA74GbmtFWpkXwcAu9opvQ
	(envelope-from <stable+bounces-254371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:27:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC25D7754
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891A5301F7AD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020A3F7A93;
	Tue, 26 May 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vN9+T35A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51D2D8771
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805235; cv=pass; b=C/wbZT2UgKJUgbRNBUc+vYJ8UpTcVPoQ3X88EhLTRLvd9f4FTxKwxaz81R6Nejf5djVFT4jlNT/AswfqzqmXvbGxzI2Wdu7dsQ7UIPK8Z7/W9VxdRD5aYpWd8lFrOFTIp8R9Bwelz9tsM5AHbar4mgO/tDlCWOD4xyLWouWQBHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805235; c=relaxed/simple;
	bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFVcPZ5mPoEtsWFPXGoD/7nRXrJqCqumP6jJpCOYGY+kSOaZuNs62nIFMxahMbhXRVkCCkudhlfevvtcxK36mwD3xhzMkWKP51rMCX2ppUjvUMxm7J++e1sN+pFr0H1cyJHT2ZC0P/kQqEfExhtX3Rz9gpLXr/tB0wyJyM3PocA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vN9+T35A; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso282a12.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 07:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805233; cv=none;
        d=google.com; s=arc-20240605;
        b=UQ7OekPQDhHuzRcz61p+PPntG8DHLNXNnkJVFga31aD19P6Iq4QMPLhbfspF4jbaY7
         RQi2kVKTfmF3OfQkjenruKyflA8CCXw1wbHkr91cH/0OSrSBFkiAN/8ed7NWIc74AM1X
         eqmhTZ4GY4bwmDO+JZX8FvtNn1aS2D6CtYtM5R40sjg3BQRqv6C4WF0eINU1TUW0ABMX
         S7Q94epzrK10BWeCIYmRdtWpdkREjOh/IuF18ozk/9z18DBZafEqNFv8I/D1RarzEG0A
         UkICEb4C6OWfqIktVztWjag2UNK2CEhuhKXwJ6GMMMlCFGmgyRQwgncQHcwO9v4iW683
         rfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
        fh=1o20sBzlLYE1lB0q1fQc8n5+60QzzgdJCpT94M1vVn8=;
        b=YG7P9aqDkuLF/ogsHsMpSjNkNrODHPgkW05v+oj01rnknytbaq9TSqJ/C3gfDjTQkj
         OEs9p7FI4C/XFxm5Nd3zImrGcf3HRs+WubEmofgzR1Ixc+qjGyf9s+3pdLPjI5HKkJrx
         tF6pdQpJDo3TgaJ4y4RQigFqBBQzUgDSJBvyLOuR7CZW881u3hAb93llK1wXXaWQ4aJU
         RKMg81EgWziLwUxL3Foyv0S6AfR8OG6f/eEWdzRffs6XqF3Wq4O8cvT8/jNCxGcyGc8t
         Ziqz6KMI9P4/c5z54zM400+7QY0QuHnFeGadJpCntDQBEbJE/V0K+7iD3QmYhzb1W+J9
         Ru6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779805233; x=1780410033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
        b=vN9+T35AXfv50Akk6vtsbYF2nFJKLdWi72cOx5ZoAVQ92E3QNeLZp00B/ykXL3DXYH
         zY1+ZSRgw/VnzBaxmdEaNehRkoOlk3FvkYJtWLltiLwMltQC4WsAr883LUHBHTxTgrxv
         +vhHBt8hlRVRxWUrIeMzU6Zp93DuYo6iEgh+pLVPMUJvgE4iChlHp7iyouuwrAI+u1tx
         zDBeHyNq9xhrxjQVnx5pb8BmfC6JEcfIJKvwRWbGxQHi8vtE0PxgADHeXlBvN7qXtwdH
         DI81E1E+f33Yu/dexdW9BM/hykJYZYBrmZ9vCGMn2v7o7b7CgX2IKJuE4gpQcRlwK5DZ
         +/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805233; x=1780410033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CWZKnF4fD4I2Too+Zira9WctIofDbV0eEFuGE2wou8=;
        b=Xtnp7A1ZmadyiEPXBbiChLwPhf+cwzdYYnEb+pw96tp2KoqfY2lL5vTUSpWL7bEIjN
         uWDFMU7/sT56Yjq8rt39bTe8I/71a0vUJwUMb1ljeSyXcXVjKj1gJlL4n4R6cNvD3/yQ
         uv8or8tu6rjVFW9ZQN6kymK4FEXrTciwJXt++jU+d3rxPpeXs/aVGfjgJxSEXnREjTzr
         cVPS57/PwWOSHStg/tdx6CfAu9AJqC6RLY6Fq9kFhVCy0KZmjyEPDOcnh9j8qxCL2vQh
         fauYmrl4VRSGhCJe/JHPX5IA5tRQHpIhztkyS+9T3+htkf8IdVS6WQipyyw8CpUIp0zd
         nAyg==
X-Forwarded-Encrypted: i=1; AFNElJ9DYB4b/GMBhplLixUkGZwrjUwgfE8wdFATqdcG2Zviy2Gh4qyN1UGvxHARo11Ggqx0C5ePppM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydKWWhtmqRyMxl+tjj09cA/kZkYFcvEld+nfGxStbIWUzZ+D9
	TMKAvF2g7lNaNVUQlj7wwu0t4S62hjWdzlvCtPdqPmoPV4ak2oz5G5daILH9XO0pKmGAckAf2XY
	5nufTbnxG2LlGO9pC2wrMasu458yHWjfT4GC0j+XJ
X-Gm-Gg: Acq92OEYmdQ8vFSRjJezaVOyvCPPZrQiJJcdsokehQgdl8DT6f0I6FSkeyGT7is41G7
	znT9fjfIJ/CN6V+PRb38rMF02z31G6UT03DEc+YDqcZYt5SbYdhAuBljgHHfEAthFQMbNuGTsob
	ECMBDfs1N/8IauIpxdWjVsXhSYlmfuXIHZzsJCfU7Zgmv1KR+/DqBRUC5vMIInVtkLOBpQNcefj
	u+H5JFGp9BBka2CYtJgW2VLs4TsUTVTvce6p44Rs76CUtN68RtaIgbg2xiFMXHtdb1ipCx6SJoF
	gkKGZRhXlstPF9qIVWmdz/uTofuV3yIbohySIrLUsHbXiIo=
X-Received: by 2002:a50:fa96:0:b0:671:dad9:8caf with SMTP id
 4fb4d7f45d1cf-6890a240863mr120407a12.5.1779805232369; Tue, 26 May 2026
 07:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com> <ahVrgomLQ14ncWTE@redhat.com>
In-Reply-To: <ahVrgomLQ14ncWTE@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 16:19:56 +0200
X-Gm-Features: AVHnY4JPFyO-HcZfBytQtZyfI926iiU_liXFjEs1d_wK1OpTf_515g_lKDLqDdg
Message-ID: <CAG48ez2qviMSwsFCa24NToscQ1E8ti8e=vinn9e8kYWDJUC82w@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254371-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D2BC25D7754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:44=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> Perhaps proc_pid_make_inode() can record task->self_exec_id in
> proc_inode ? At least this can help to fix the
> "if (ptrace_may_access(task)) mm =3D get_task_mm(task)" pattern...

Yes, I think something like that might be a good idea for files that
access the process in read/write handlers, though I think recording it
somewhere in file->private_data would be better than putting it in the
proc_inode.

