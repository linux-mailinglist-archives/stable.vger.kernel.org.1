Return-Path: <stable+bounces-260613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fm8NLcY6ImpEUAEAu9opvQ
	(envelope-from <stable+bounces-260613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 04:56:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9F644C38
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 04:56:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260613-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260613-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B3E303748E
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FD3DBD5C;
	Fri,  5 Jun 2026 02:55:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C802F5313;
	Fri,  5 Jun 2026 02:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628152; cv=none; b=nbOJKb+a95FU3MdSgRiAF9kbmFNrnth/bdiraPlgG/Q17h1qyIQRBU9PYtL1NYDL9cwaa/wHe9N0c2sd0pCaopCe3WiGtSu/gUVEr8klSNgcn8RN+N3muSK+OblOr5WeTEDxrLDIA2ZmcTMIy7lrVNBzNbl45ACKYBkYZYtJvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628152; c=relaxed/simple;
	bh=RQGbky2LJdGJcg/SIt45tKn8WWBgyAkHdggX9OENauo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgWxFivGci/AdKHGhZ2FLzHd9lyHPeTJvgNegyZG0U6mKrP2vbRYPYjJGsQh09qKfjEISIXqMk3eGMzGcFDekfD600BX0OoVr/qhYNsJfZzZM/wNkJzad5BvhJ5cRKfVRnvcLpmpwS3+p0D40dOTeyyzIudIV/j/KF8nIZylSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gWmJQ2Fc0zYQtnr;
	Fri,  5 Jun 2026 10:55:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C3614058C;
	Fri,  5 Jun 2026 10:55:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCH23+fOiJqhROsAg--.32317S2;
	Fri, 05 Jun 2026 10:55:27 +0800 (CST)
Message-ID: <78e518ac-b207-4d90-bb8b-b8063be374cb@huaweicloud.com>
Date: Fri, 5 Jun 2026 10:55:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bpf: Restore sysctl new-value from 1 to 0
Content-Language: en-US
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, kees@kernel.org,
 joel.granados@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
 <20260603105317.944304-4-dawei.feng@seu.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260603105317.944304-4-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH23+fOiJqhROsAg--.32317S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryDCrWrCw4fAr1UXFyDtrb_yoW8CrWUpr
	Z0kw1UK3yjgF9Fk3WYgw4SvFWfuw4kXr1Ygryvqw1UA3s8trW8tryq9rWYqF1avFsIgryr
	ZFWa9Fyq9w4UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	7PEDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:from_mime,huaweicloud.com:mid];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[etsalapatis.com,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn];
	TAGGED_FROM(0.00)[bounces-260613-lists,stable=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:martin.lau@linux.dev,m:emil@etsalapatis.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:kees@kernel.org,m:joel.granados@kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xukuohai@huaweicloud.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xukuohai@huaweicloud.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,seu.edu.cn:email,huaweicloud.com:from_mime,huaweicloud.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FD9F644C38

On 6/3/2026 6:53 PM, Dawei Feng wrote:
> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
> bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
> condition is never satisfied. As a result, the modified value is ignored,
> and bpf_sysctl_set_new_value() fails to replace the write buffer.
> 
> Fix this by checking for a return value of 0 instead, so cgroup/sysctl
> programs can correctly replace the pending sysctl buffer.
> 
> This bug was discovered during a manual code review. Tested via a
> cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
> Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
> returned 8192 and the value remained "600". Post-fix, the BPF replacement
> buffer properly propagates: the write returns 3 and the value updates to
> "foo".
> 
> Fixes: f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")
> Cc: stable@vger.kernel.org
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>   kernel/bpf/cgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a0b5f8cd8b10..3f06e2270f5c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>   
>   	kfree(ctx.cur_val);
>   
> -	if (ret == 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>   		kvfree(*buf);
>   		*buf = ctx.new_val;
>   		*pcount = ctx.new_len;

Acked-by: Xu Kuohai <xukuohai@huawei.com>


