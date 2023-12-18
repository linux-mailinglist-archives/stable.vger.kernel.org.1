Return-Path: <stable+bounces-6980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41161816B46
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433F71C222BF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9ED156C0;
	Mon, 18 Dec 2023 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDEEg9Bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BB182C2
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BBAC433C9;
	Mon, 18 Dec 2023 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702895908;
	bh=H3PZJ4mJ8TS8cqrxTBlve6asYlZPXQiuH4ihuHnSoXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDEEg9BmqOXgNCjVFBEAVGNAPX4J5El4kQ4uqbo/AefcAw66xawC+eQquvYkoUhUF
	 9gM5FACvklhn3L6ecsGJUEZ1okE/zIcE6zutU1eXa9Uks/lhrRnSy7VhHG/4DJJQjK
	 O8tmzjfsANyIPsdKv3l49YcRrNUelyi+GYmMTldY=
Date: Mon, 18 Dec 2023 11:38:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: paul.gortmaker@windriver.com
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] ksmbd: check the validation of pdu_size in
 ksmbd_conn_handler_loop
Message-ID: <2023121813-compactor-lettuce-4ced@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <20231212184745.2245187-2-paul.gortmaker@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212184745.2245187-2-paul.gortmaker@windriver.com>

On Tue, Dec 12, 2023 at 01:47:45PM -0500, paul.gortmaker@windriver.com wrote:
> From: Namjae Jeon <linkinjeon@kernel.org>
> 
> commit 368ba06881c395f1c9a7ba22203cf8d78b4addc0 upstream.
> 
> The length field of netbios header must be greater than the SMB header
> sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB packet.
> 
> If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to `conn->request_buf`.
> In the function `get_smb2_cmd_val` ksmbd will read cmd from
> `rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
> detector to print the following error message:
> 
> [    7.205018] BUG: KASAN: slab-out-of-bounds in get_smb2_cmd_val+0x45/0x60
> [    7.205423] Read of size 2 at addr ffff8880062d8b50 by task ksmbd:42632/248
> ...
> [    7.207125]  <TASK>
> [    7.209191]  get_smb2_cmd_val+0x45/0x60
> [    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
> [    7.209712]  ksmbd_server_process_request+0x72/0x160
> [    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
> [    7.212280]  kthread+0x160/0x190
> [    7.212762]  ret_from_fork+0x1f/0x30
> [    7.212981]  </TASK>
> 
> Cc: stable@vger.kernel.org
> Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> [PG: fs/smb/server/connection.c --> fs/ksmbd/connection.c for v5.15.
>  Also no smb2_get_msg() as no +4 from cb4517201b8a in v5.15 baseline.]
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  fs/ksmbd/connection.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Now queued up, thanks.

greg k-h

