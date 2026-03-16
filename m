Return-Path: <stable+bounces-225639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OnXN1o+uGmxawEAu9opvQ
	(envelope-from <stable+bounces-225639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:31:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCF629E482
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99A03301DEFD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE203CF032;
	Mon, 16 Mar 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xvlxiznf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D31E7660
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681821; cv=none; b=P4RLiemH2Co44TSx1yC3o8lFB2KYcimntm+cVgtsXpET6bkFO0cmW+IwK2eO6EBasFskTUN1sq34u7Jl5cExnMCmglSvHKViQKhHLyF9vjV5DO3p8CL5cg1ze40v0xsmPHOt7FKkpqPWhTTI5W1uqT19CXSMALqDO+sHf4tASfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681821; c=relaxed/simple;
	bh=XUMpQ+10FZHfgJfnOFqGeZ08vd90HbRW79j6d9PUQqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTQX/BVrDITkdSYXDW0aX1aTy4+Kzo0zThtcoBTnx6ygOFy2V5LBeeLwlDwB6grqJWnkkNW9D1ZcXksD4xPdCT42UNBF6eMZNVgTPnh9fTO4qBoGCuS1men8IK6YMXUCAQvyeVXnNQP5FzHnrgNqYMxp433oHBeqmVaTVpy8KXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xvlxiznf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853aec185aso40066515e9.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773681818; x=1774286618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8b9XuRtDgXlhvc/ORfCs98sIv3e/g8y530Cpr28kNVA=;
        b=XvlxiznfcMaQbVAYfj3rmk18tyGMrWJAmrQNcUh5RWdwHDQyKFBX6D27lc3J9IKViO
         dWRvrhb3HPZOyN/qPmugTkXMcQlcN88z4hTDNBDylSl+jwfs8txzUmiy4i0uTIKJTyUz
         gu9TDslsh/rSjQobhyliRjXbSgo42pFYeUtCDEZCFQzjHtl998qCkk3BbvW3auxjiV32
         JQUSP8D8xxuzYKLyWNaWgy7JRMdAH3hF1/GrwnLx/DQ5u4m7lkv6NAsbKD4JotTzYmvA
         UYeoG1y8K3Gkbb4s7oGa1cHUE4RoQWozwC6iN3lr0q8s5f7bXTittzLWYzwKL73Sj/tb
         dUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681818; x=1774286618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b9XuRtDgXlhvc/ORfCs98sIv3e/g8y530Cpr28kNVA=;
        b=O92AS4MrnixfC+4zzogveepClTJTdGx3CRJnr3MziTuyLOoAKdgg4d3ViX+Y1AHsOC
         l7YUq4t+vCRMeaFqUjWRByOynx8cg/KGw7imuzL9TB2JsrOQJPSy4KP2RZdh+DJc3NuB
         Sa5uFOBpmUqBBNeIaY/MtJdIoFpc0wh3kZSfDax3pHxdRC31R2eLYoPEb+YmNpxEcjx8
         W5wUDlX1J3sdx75u250svDxvyRVwNWo28fVxgBp3ZlZ5bmWoCULEnj0JksTtqLFC+m9J
         ZCAW8dOxd2+/FUu4O9bO3a17VaCwDZkIQzot0pYFpCEzQNGDbxT5q5AkmmsZwD467o14
         GG8w==
X-Gm-Message-State: AOJu0YzD/RUXiOJvGSjYpB2OZXU50WhdnLjM9A53i427tnjI55KohQ3m
	g9HhlcER7RpCdWmlj3PhbM6nEWNbhye7iTB4RGH6XRSt090M+/FFLrDYjvgffffHrhQ=
X-Gm-Gg: ATEYQzzUEKEvzpEHOZH3YARQvlCbgR8bpWiwbK7PRgLgX4Gf3IKjRaq4hAokQPhb6Sw
	2IzuD3IuGJLoeKKvJdHD90q9K+kl38L/St0IBuRdz1KM9jSlFzwpmuq97nlNGVvRKDOJ+imLzps
	/nAhVIQCKyNXbcGDLTpxbaMcqZxWBvV4BOcIdsmYVY8LDbJe82wZabJceX/ZAjLV71q/xVnRC3n
	xaVNNFcZuBCn8rRwExv2TgZrkouHjimhmZXo3yxmZkzfuMQFyjjfuqJ3Q5YIsu4b249bGGBXSK7
	o/1ylKfAqwrEeM5BAxsx1WkecQjWph71hcj94Ye6nmmXRNu08FXMzfMYGlViG5RJy/VWZUVCHQz
	IsBFqgSacwU8MF06FHBNcemtVRa9Qen1e2RygsCj8YAyxNqkNMUWtaV+zNsefstijxfTWVoNmNM
	jO0ZUyAlrRzxpq0E2xMz6j3r7l/IX5CjHSBXtX55EAS5JZyHomlS5/R1E=
X-Received: by 2002:a05:600c:4514:b0:483:78c5:d743 with SMTP id 5b1f17b1804b1-48556709e2cmr221416935e9.28.1773681818463;
        Mon, 16 Mar 2026 10:23:38 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0c34sm15142622eec.7.2026.03.16.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:23:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:23:32 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, thorsten.blum@linux.dev, pc@manguebit.org
Subject: Re: stable: [PATCH] smb: client: Don't log plaintext credentials in
 cifs_set_cifscreds
Message-ID: <qy7umjmnkwhtmixp7giob2iqstrwr6crntuyakibcdpqhzo7ty@bgbcu3bntz5d>
References: <eijo3pknvy4gl2xh23by7kjdxpoc27an3dqfmfttremp4xb53o@z2kq34l2onvy>
 <2026031616-flashily-strung-a688@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031616-flashily-strung-a688@gregkh>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225639-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.dev,manguebit.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 7DCF629E482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 04:53:02PM +0100, Greg KH wrote:
> On Mon, Mar 16, 2026 at 12:49:00PM -0300, Henrique Carvalho wrote:
> > Hi,
> > 
> > I believe the following commit may have been missed for the relevant
> > stable branches.
> > 
> > 2f37dc436d4e ("smb: client: Don't log plaintext credentials in cifs_set_cifscreds")
> > 
> > Could you please consider backporting it?
> 
> I see it in the following released stable kernels:
> 	6.12.77
> 	6.18.17
> 	6.19.7
> 	7.0-rc2
> 
> And it is in the 6.1 and 6.6 queues for the next stable release for
> them.
> 
> Do you not see the same?
> 

Thank you! I only looked in 6.6.y, saw no emails from stable and assumed
it had been missed. Apologies.


