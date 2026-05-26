Return-Path: <stable+bounces-254237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFfLBBMEFWroSAcAu9opvQ
	(envelope-from <stable+bounces-254237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:23:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83515CFDCE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15AD93008C21
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E31C01;
	Tue, 26 May 2026 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvLJJEmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E372F7EEE
	for <stable@vger.kernel.org>; Tue, 26 May 2026 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762192; cv=none; b=rPN0/w7B58XqUy6GDweP8v7l2d0zatsns8TIG5rRKy95ese8aYu3zOXp/37kcTopd7+ypgvAYkHuA1gqzqpChTGJMMqxyXqaoj65RG7fftxJz+hIY55VGGO4W1dnUv0akw1d7Xv1LOv/QryD73lgoTP10QcdvDKUCABnWJlQulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762192; c=relaxed/simple;
	bh=uk5GYeeKGwu0Z4CDNEbqil6KWhV+Z2Z/+HjirYEdOG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLUAOVFvobZgAkgI54VK11Jom8f8Ai7nyU21AsDCWY9OCR8S+oPT2mdowBMm4ySsMM2/BW6kPvXOblBK1M/FGtwRzG9ZbD8uTsG9/Xp97zu1ZLqcC6P/kHjoSquXg/J3MG6RoNY4aTZnpNU+LLdQW+F88JSiBLka2Zf4WaBjd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvLJJEmg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A551F00ACF
	for <stable@vger.kernel.org>; Tue, 26 May 2026 02:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779762190;
	bh=FZXi6dqaQN6VkeUOCpAYPeag7FUXUWT0/Itlu2nAFLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QvLJJEmgZ6AY/3+a7Tcuw7SA46uxmHP+xrHv0BRYCYOQ49MqqEV3yQU9kvQUrdz/j
	 44IJpoPMn8VOs67QG0V2Ce6t6p+P4BCXOy9K8OX+bKfpwE1t5m9CxGGIClHp0hn7Wn
	 BNUE3iB2UMQm73eRUUAhq31E8ZC+DKvZ5nmWEc7nX9OZlOE3YTGmrOny59VNmyesO0
	 r/f8ZkxJyfMbSBpu8fW5qBTRFUkPjCEBlorI4V7gp7xsY1xXQYDR6UAW+gP6ks7jy7
	 30PpJqKKyvv/9xdjpU4CgP8A6dKHtVSLDiZVZlgf5Z4TwTsrWtpWNmkKtMOUkyjsJc
	 bCKZv5bCRvFAw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so1407643566b.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 19:23:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8yGY3L3F541F7xVfQxDsZm3nzLi7G7Kr/bt9ap62H7TNBsm0wo4LMu2b2TPN73rXfMGeaPasQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIw8jmuHuBeIADjkzI7P9pKWZLPHbrdVVVps8AOoaBTk+SuFnl
	7HSyR5ZrDBapQFMz8MrFxAJJ1o2TKZ/LvgFl0ylWzHd/2jUsFvgwkyZ8G/ShDYDPYhiCyKx8Q1u
	WKTzH6f09kCbDNkKmhWkf4cos6gSe72E=
X-Received: by 2002:a17:907:3e23:b0:bd0:8e74:85a3 with SMTP id
 a640c23a62f3a-bdd25ce8df4mr1068593466b.26.1779762189346; Mon, 25 May 2026
 19:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
 <20260525104130.1252-1-alvalan9@foxmail.com> <tencent_88A30183B6BDC6E9A34612CF7A10071E4605@qq.com>
In-Reply-To: <tencent_88A30183B6BDC6E9A34612CF7A10071E4605@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 26 May 2026 11:22:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_=z9THUikoBQnCCMcq2yoA14RdwTWNS+4eQWSiSQMfKA@mail.gmail.com>
X-Gm-Features: AVHnY4K_psdDFSnQz0LHvtbZM7XAdT2VB90x4_i6vPgZxISC9T2cJ9DULpSHGIU
Message-ID: <CAKYAXd_=z9THUikoBQnCCMcq2yoA14RdwTWNS+4eQWSiSQMfKA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y v2 2/3] ksmbd: add durable scavenger timer
To: Alva Lan <alvalan9@foxmail.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stfrench@microsoft.com, d.ornaghi97@gmail.com, 
	knavaneeth786@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254237-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A83515CFDCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

@@ -817,6 +968,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work
*work, struct ksmbd_file *fp)
}
            up_write(&ci->m_lock);
+           fp->f_state = FP_NEW;
             __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
You seem to have missed this change above.

>  int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
> @@ -934,6 +1085,8 @@ int ksmbd_init_file_cache(void)
>         if (!filp_cache)
>                 goto out;
>
> +       init_waitqueue_head(&dh_wq);
> +
>         return 0;
>

