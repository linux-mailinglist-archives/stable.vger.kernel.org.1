Return-Path: <stable+bounces-165111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E3B15257
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E353B1AC5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551CA204863;
	Tue, 29 Jul 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQk0aL4a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xv+WQS5A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQk0aL4a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xv+WQS5A"
X-Original-To: Stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826C20101F
	for <Stable@vger.kernel.org>; Tue, 29 Jul 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811258; cv=none; b=E2wwCqqq5CoWG1UvV51k5WOg2jgsvy8nDSqhsK/liTWTDxG9+Z98NUo27InvY0Ymm73VMv70934qZemWKmjvM50SHvSpS2mkg40zgbLXtGEs8M0x/8wgYaQYlNq8VHrQ8YVU7Ivvn/opIH2bTpbz3Uh3z3fuBrUNa8FnTp0fEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811258; c=relaxed/simple;
	bh=G3Ach0t6b5cLGvGocY4EtecsZMsdEyUrD+TGmYhL198=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvfCsrCjCFE/NzyjIcx5I3kYuuXP8D2TU6+eIKhcVAXhGE0YBz1EhMqmaTxNbfpFERQh84hoyXOQCYL+hgXL8UMEwRtb3/RVcNYGZnmWFLcroUynY4T8xNdjJ2y0CVfG3m632UFREhsJnlRoQPvrmyxJdxxX+o0lqEahZaILphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FQk0aL4a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xv+WQS5A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FQk0aL4a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xv+WQS5A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CCA91F444;
	Tue, 29 Jul 2025 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753811254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbadvy2I8kgUx32UrQxaZhf8HYv12bSN2trLHVN7LBo=;
	b=FQk0aL4aYG3AkM46bYsohiUwyfxXZpf9qcAOZ/tyvIwz59JNvi4fRmJSPTvF3f5MaGYCji
	aXNLO4jf1i+/YWDAgNpNwpAtIlMN8wfIntLWqaTwwHgvFxCboj5nb9yf6TMLXdsez/4gg1
	iBNRcWgueHg1AFHVe+5R/kwNLP5Ya6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753811254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbadvy2I8kgUx32UrQxaZhf8HYv12bSN2trLHVN7LBo=;
	b=Xv+WQS5AEvmsz+Tb6kVc2cszPeVaDXft3Ot9PzC6DEDVhwZeEYKUAoFu/szJ2hj1JqzbD/
	zzsiX/Ncq5wR10Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FQk0aL4a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xv+WQS5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753811254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbadvy2I8kgUx32UrQxaZhf8HYv12bSN2trLHVN7LBo=;
	b=FQk0aL4aYG3AkM46bYsohiUwyfxXZpf9qcAOZ/tyvIwz59JNvi4fRmJSPTvF3f5MaGYCji
	aXNLO4jf1i+/YWDAgNpNwpAtIlMN8wfIntLWqaTwwHgvFxCboj5nb9yf6TMLXdsez/4gg1
	iBNRcWgueHg1AFHVe+5R/kwNLP5Ya6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753811254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbadvy2I8kgUx32UrQxaZhf8HYv12bSN2trLHVN7LBo=;
	b=Xv+WQS5AEvmsz+Tb6kVc2cszPeVaDXft3Ot9PzC6DEDVhwZeEYKUAoFu/szJ2hj1JqzbD/
	zzsiX/Ncq5wR10Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08E3313A73;
	Tue, 29 Jul 2025 17:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRdPADYJiWg8cwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 17:47:34 +0000
Message-ID: <c2d3a4b6-6b1c-4f9c-982b-4adbc558e1b7@suse.de>
Date: Tue, 29 Jul 2025 19:47:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: fix handling of tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com
Cc: Stable@vger.kernel.org
References: <20250729164023.46643-1-okorniev@redhat.com>
 <20250729164023.46643-4-okorniev@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729164023.46643-4-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4CCA91F444
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/29/25 18:40, Olga Kornievskaia wrote:
> Revert kvec msg iterator before trying to process a TLS alert
> when possible.
> 
> In nvmet_tcp_try_recv_data(), it's assumed that no msg control
> message buffer is set prior to sock_recvmsg(). If no control
> message structure is setup, kTLS layer will read and process
> TLS data record types. As soon as it encounters a TLS control
> message, it would return an error. At that point, we setup a kvec
> backed control buffer and read in the control message such as
> a TLS alert. Msg can advance the kvec pointer as a part of the
> copy process thus we need to revert the iterator before calling
> into the tls_alert_recv.
> 
> Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 48 +++++++++++++++++++++++++++++++--------
>   1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 688033b88d38..cf3336ddc9a3 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   	if (unlikely(len < 0))
>   		return len;
>   	if (queue->tls_pskid) {
> +		iov_iter_revert(&msg.msg_iter, len);
>   		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>   		if (ret < 0)
>   			return ret;
> @@ -1218,18 +1219,47 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvmet_tcp_cmd  *cmd = queue->cmd;
>   	int len, ret;
> +	union {
> +		struct cmsghdr cmsg;
> +		u8 buf[CMSG_SPACE(sizeof(u8))];
> +	} u;
> +	u8 alert[2];
> +	struct kvec alert_kvec = {
> +		.iov_base = alert,
> +		.iov_len = sizeof(alert),
> +	};
> +	struct msghdr msg = {
> +		.msg_control = &u,
> +		.msg_controllen = sizeof(u),
> +	};
>   
>   	while (msg_data_left(&cmd->recv_msg)) {
> +		/* assumed that cmg->recv_msg's control buffer is not setup
> +		 */
> +		WARN_ON_ONCE(cmd->recv_msg.msg_controllen > 0);
> +
>   		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>   			cmd->recv_msg.msg_flags);
> +		if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {

Hmm. Looks as if we were getting MSG_CTRUNC even if no buffer is passed.
OK.

> +			cmd->recv_msg.msg_flags &= ~(MSG_CTRUNC | MSG_EOF);

Not sure with this. We had _terrible_ issues with MSG_EOF not set
correctly (basically the TLS layer would wait for more data to be
received before the record is shipped out, causing massive delays
and connection resets).
Any reason for clearing MSG_EOF here?

> +			if (len == 0 || len == -EIO) {
> +				iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec,
> +					      1, alert_kvec.iov_len);
> +				len = sock_recvmsg(cmd->queue->sock, &msg,
> +						   MSG_DONTWAIT);
> +				if (len > 0 &&
> +				    tls_get_record_type(cmd->queue->sock->sk,
> +					    &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
> +					iov_iter_revert(&msg.msg_iter, len);
> +					ret = nvmet_tcp_tls_record_ok(cmd->queue,
> +							&msg, u.buf);
Can't we just skip this part (ie _not_ receiving / reading the control
message contents? It's not that we're not doing anything useful here;
for any TLS Alert we'll be resetting the connection.

> +					if (ret < 0)
> +						return ret;
> +				}
> +			}
> +		}
>   		if (len <= 0)
>   			return len;
> -		if (queue->tls_pskid) {
> -			ret = nvmet_tcp_tls_record_ok(cmd->queue,
> -					&cmd->recv_msg, cmd->recv_cbuf);
> -			if (ret < 0)
> -				return ret;
> -		}
>   
>   		cmd->pdu_recv += len;
>   		cmd->rbytes_done += len;
> @@ -1267,6 +1297,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>   	if (unlikely(len < 0))
>   		return len;
>   	if (queue->tls_pskid) {
> +		iov_iter_revert(&msg.msg_iter, len);
>   		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>   		if (ret < 0)
>   			return ret;
> @@ -1453,10 +1484,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
>   	if (!c->r2t_pdu)
>   		goto out_free_data;
>   
> -	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> -		c->recv_msg.msg_control = c->recv_cbuf;
> -		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
> -	}
>   	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
>   
>   	list_add_tail(&c->entry, &queue->free_list);
> @@ -1736,6 +1763,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
>   		return len;
>   	}
>   
> +	iov_iter_revert(&msg.msg_iter, len);
>   	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
>   	if (ret < 0)
>   		return ret;

Huh? Why do we need to do that?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

