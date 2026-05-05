Return-Path: <stable+bounces-244140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG90Bqvq+WkLFQMAu9opvQ
	(envelope-from <stable+bounces-244140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:03:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E94CE1E8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97EFC306CB38
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD742EEA6;
	Tue,  5 May 2026 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRUgOuX7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO2d3KVD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD3274B39
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986070; cv=none; b=CIbtdKOhlYqjIDEadZGemWh4zcsBc1EcNf1l0HhIC9d+y/PXxYkBSQMqiohUnBpEA/STSaXJmuby1M8A4qeypEgPxhhQI+cvl5RJDqeJd7rTfD2q3287d+6m54/XoaOy4oVyA0Z8F9Mo8Qwjun7kNcVe4aH1d1eAmUzXq98VLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986070; c=relaxed/simple;
	bh=GYtI7bDD+MMFGyL+yGGnqCAyzGu+/x6qxQ2tUmlG8HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkIvVNkNsVdi7jSPb+9/KQAWp3dspqz+5c8yt4tMTOPkRg3Gl8g3g4vgbHWzPBdF2EdtW8UMNVItPzmYVcHgg54Cc81ZldQG96ObUvO1T4o29MuIdaDLpAmK6147KioFhbo6srJIFAYasrABo8Ghp6motw0PggL5xOq6DzVuizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRUgOuX7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cO2d3KVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777986066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ify9Bi6CHKsDFsBeOr/60tpIhk/Zdvw/emSfXb/I8Gw=;
	b=YRUgOuX7qaTwK6CSnAuCkQJy2AosO8QFiNuWqrUwpdrqlusG6xGcguAB0Lxu6+x0GukeKW
	3iMGvGxOBlAioBkLENQS+ixFmvemA2nci9YhYKhUZpOM/iMZcR3vP/nnYg/VtRVOE0K7zb
	YevXeUU2YyodaSQwvBArgnCyn5NihWw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-X8QF1PyTP9S0xrYQd4m4BQ-1; Tue, 05 May 2026 09:01:05 -0400
X-MC-Unique: X8QF1PyTP9S0xrYQd4m4BQ-1
X-Mimecast-MFC-AGG-ID: X8QF1PyTP9S0xrYQd4m4BQ_1777986064
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso37273785e9.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777986064; x=1778590864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ify9Bi6CHKsDFsBeOr/60tpIhk/Zdvw/emSfXb/I8Gw=;
        b=cO2d3KVDAE6qASLPkN6LkUjZRg+KnWcmCubgsKCDzTW8mISkH91B+BwoGeqxew4aQp
         IilFpSOsli5REqQ0kK0VdhXfnFvTmMlMnaJTJ5oTOWt3GXXlMh5DzZ58mfVsSqBPAtH+
         whRywUlAv6K3BSi6FYMaI868ktVQEzbCm5L2Ue0iVYJ4wxYcvm0BBqE114Mbyu3Ebvq1
         pEwEK07iqFb/28+4tEVw8zHKqzPNt0mCgPkNUTnaaBeOARasWyAC3ZBEZ0Eydz0OjBz3
         oyMB2PUDMjkI4jVNOesTKKaVKlDTUs0Coq3g157qXGwLLE+SE3VfS+uOjmyL/IpEl4d0
         3xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986064; x=1778590864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ify9Bi6CHKsDFsBeOr/60tpIhk/Zdvw/emSfXb/I8Gw=;
        b=m4hCHkppr/rBSYlqtnHw6zEyA0xdF/JfqN0f0ICW9O5cU5pmTmTMZHLZWmZ3RrDoiU
         ZU+e3sj/Wu11Rcj6308T0KZNwCzLnTaWrAbGNGGAG1cK4rjefK74RtO+wzm8mjw2tglW
         n4n+fhsEfPaq+O94BrRqrZf0eoo9qeC4bOSzF8UN/xoLRqjufMBxLtFjaWCjoA6iwxha
         OcramitYNxQfKx1idHrxSCFmMOWQIzJTki0wgSOXtU0aNbS77gKgzB0KchDV+0reoj5N
         xuoiW3eknWaJ+JRZzQngsRZMmQ+N8tpGe2HXAN0M3z+8+wdLcXcz6fOoue+79Jtt6Vp/
         kaCA==
X-Gm-Message-State: AOJu0Ywkz+oLFCbLC90lLPX2q8htFENem8ALk6szfZaaVyKjoK1LPq3V
	8/HNgYPXA0SdBmFTE9B98RKXG0rV2DDF9FvDHEb4UMILG6uigsPRUScB6CAsa92cgvlsOYRPjpa
	Bx5A+E17FZMDGVDAqLA1hjFJ8VeXxZh5qFtqu9yFiG7qims5S8l7rnB3G2g==
X-Gm-Gg: AeBDievFJotVXcx71+Syxl9k5Uw86F3277SbFCYUTOiz9IrPcQCUlbE0DNsIQI55clu
	pZnqXLOgEC6KlzWeeEcTKzz5T180kTmdpuVNoeMq8jSqnN/61bgF/yTTean+2JKZUt2HfOAvMmE
	9HKP8q2236+W5bEvYCT3rWkitQ+DxQR7BWT/afYUi9jvzpMtxL9OIF0vGDLo8BCeFjwY0PiVZnm
	r5iB6iOY5J64mm3Wo5fIZ7zq5X2mpp6tgDftl6/SIKEZwNxzB2sgheFCp7+q43JRctcKpzlwHgH
	IDT/LJET5TSAl91NdDlTxT75lgymVGKLwCWnWuGNxyRhb+tCKcRsbe3KnmXZNNAj/M3nppzSrJO
	TQEYCgs6jaLqZAzC7q1kY021JdmARFNNCIlUVcO3PcYW0ZIBSLQhz/miR3o2xBkjGtcY=
X-Received: by 2002:a05:600c:c16a:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-48d18ceb33dmr49000295e9.25.1777986064109;
        Tue, 05 May 2026 06:01:04 -0700 (PDT)
X-Received: by 2002:a05:600c:c16a:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-48d18ceb33dmr48999545e9.25.1777986063581;
        Tue, 05 May 2026 06:01:03 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm391720155e9.4.2026.05.05.06.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:01:03 -0700 (PDT)
Message-ID: <be3bc819-b695-4626-a1e3-a9f791d59001@redhat.com>
Date: Tue, 5 May 2026 15:01:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, jmaloy@redhat.com, ying.xue@windriver.com,
 kuba@kernel.org, tipc-discussion@lists.sourceforge.net,
 tung.q.nguyen@dektech.com.au, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 syzkaller-bugs@googlegroups.com,
 SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>,
 syzbot ci <syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
References: <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
 <80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 830E94CE1E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244140-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,SnailSploit,ci779e8ed86620f383];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/30/26 5:26 PM, SnailSploit | Kai Aizen wrote:
> @@ -422,9 +422,12 @@ static bool tipc_mon_add_peer(struct tipc_monitor *mon, u32 addr,
>  void tipc_mon_peer_up(struct net *net, u32 addr, int bearer_id)
>  {
>  	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
> -	struct tipc_peer *self = get_self(net, bearer_id);
> +	struct tipc_peer *self;
>  	struct tipc_peer *peer, *head;

Minor nit: please respect the reverse christmas tree order above.

>  
> +	if (!mon)
> +		return;

Also an empty line here (and other similar places in the patch) will
make the code more readable.
> @@ -663,7 +666,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
>  		kfree(dom);
>  		return -ENOMEM;
>  	}
> -	tn->monitors[bearer_id] = mon;
> +	rcu_assign_pointer(tn->monitors[bearer_id], mon);
>  	rwlock_init(&mon->lock);
>  	mon->net = net;
>  	mon->peer_cnt = 1;

Sashiko says:

Does rcu_assign_pointer() publish the mon object before its lock
and fields are fully initialized?
Since rcu_assign_pointer() provides a release barrier, a concurrent
lockless RCU reader (like tipc_mon_peer_up()) could observe the new
mon pointer and attempt to acquire write_lock_bh(&mon->lock) before
rwlock_init(&mon->lock) has executed, or dereference a still-NULL
mon->self.
Should the publication step be moved to the absolute end of the
initialization sequence?

Note that sashiko has more remarks, even if they looks like pre-existing
issues to me.

/P


