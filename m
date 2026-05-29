Return-Path: <stable+bounces-256540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IXjHIdHGWrHuAgAu9opvQ
	(envelope-from <stable+bounces-256540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:00:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D45FEE59
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAAAA30027FC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376573ACA46;
	Fri, 29 May 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fmYfJNwg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E284371CEA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041333; cv=none; b=E9eXACi/KnvZu5Uz1HxVaWtSnQ6NrsXF56s4liUh7akPY11Rkw7D8lhrSn7ZGODb2NBHmQdPHYFAIG/oFkuttxWc9FNDsqozMfVDk2iCSZE5XfhhFEiObL/JEpW5em53Fswnbsph4cKnxIgjlma4j8uuOwrjn+pK+CxGpvpUFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041333; c=relaxed/simple;
	bh=az+YGSnbEkqUPIWgm9boM+jZptAY8k8bCMuxg4pC9CE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TFKRZulrEo+/FbcaAvart3sKsMSnlSzWnFBAkmhSTt+27Sihi+0T3uN4T0m/x+P9UwKhXNu4lBNfwdoszGwb+RFnGh1LcdHgdUr69q6uPONmT6IMkGNAv7kCwPjqPfNGgfcdcMOr1i4Eav7KUo/jwLGzUTee9548+wQIoMr0S2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fmYfJNwg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so2348895e9.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780041330; x=1780646130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NND3xz9n8aYUKvYXVex2mmyeZtIglxNaprb2v639ix4=;
        b=fmYfJNwgj6tGim4TVejSiA8dTkBmB4b16E6eNaWN0Jd6Iyqi2wBkkNrLD7GWirvHqQ
         BAFq4e39p9yb3uKWM9hwgpJsMdNtQ+HoV3vnb9JdBkPVtdjiH17rG0gKJqcLuwAxgE3W
         lDjZ3yS6DKfCKRX5PVzV2LS/DH2x9VMqWxerarG8tueOLb74nNhXTWv0Dwz0QkkUip8i
         Q1MHygf6cjHYYlkFzlf9TCLDWnvlEq0iidybDTdYpLD34P5jjLeMi7pJQxVJZEUEEyzV
         /BYRMyU2NSlbMQUJO3gmqa0W+zgU4scbSjjUICArnEl7uBUG25f64DFdyUHQvGaGByh/
         GkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041330; x=1780646130;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NND3xz9n8aYUKvYXVex2mmyeZtIglxNaprb2v639ix4=;
        b=tK5aQM4rC/nay2iIlD8jIM21b4RAxBz5DIzal6IKB/uqCcwtaGROJCSxxL2WlzP9+T
         LkcBgQL2sV5qxwyPrTHZWc97552XB187Fut1rtefSMEr9h5RtRNhMM/m4I9mnOHqJBH3
         c08ib8FpwffMykxfTgQXla0xPDNpX0c+OiWCGUYvcalCbZ7zTDOdgGKxoiHasO4FmYWc
         1hRm93Rs0doon9lKDeA8hnRB4V0CoY85WY3Ffg43neP2tB4hLllcBShoePk3kq6g43U9
         KEX4QCf7SxGrcw/kn1WnDNcjJMteAqcu/qxUNWM3WJwAJSkyuibCgy36a6Jdc3XOBgAJ
         xlsw==
X-Gm-Message-State: AOJu0YxEzMZJ5IdFIp5Sfg0+vjcnUoeqPenxxEXJVnQcbS16SdhLlFJw
	aS8zFnCk2CYflGRxV1oaocqzQs+4JJ7nHy9Aa7HWm3YQ4Kx5q3MmsKptb9IMLT4PIFKH9pW7l6u
	vk7Jg
X-Gm-Gg: Acq92OH7LW0PVODjM7ipbZRmOitcwazpb0O70Nl76K1sj8xDwLxKXiCaXm1EPcFSUA/
	e72WbyNw4mvHH3QcEplOP8locKDmH6BP6zqqlC/1SGgLB0KerguGS8+2D6cnCq+OhUe1Vs2WAnl
	+JWw4RygJciga4tmSaD9+7b3t1ZpQJgc8z/XBBwkwq2zklANtxk7JJbNo/QPVy4DJ7OhS5duG52
	aOTwb1V6p072d7pesn9rlidaRJ9e9ouNWblx4YnaX2qwyQn4k3MAn+hJXvBlshRbMULVH6IdcfH
	1V7RJkN6dJTClygoa0r+b1WPBUXC2fEI8lxK+P24GwwQSr9trNqprplC9xgxxwB0/0dbjIsWZMl
	YYae6Ipkz0TxvSgu2cC/aZSwCeVbirSYgcsSa0+90wUmOh4pg85qNQoLig/0K2CZQuF+u3IZbDP
	+QzTee9qEAeVhSnQOScSW60iGgbdecoD4RH2tgZ/3C+3VO3ZtVm2vAFcAt9yjbu+xOFIGHLO84c
	8dX5UyyvpnhT9jqqXwMoqnnLRp3OIxxtcY62qoOT+Vb7t80ZtbNPT1t3w==
X-Received: by 2002:a05:600c:e489:10b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-4909c0c570bmr22167225e9.26.1780041329849;
        Fri, 29 May 2026 00:55:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e760dsm1359533a91.2.2026.05.29.00.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 00:55:28 -0700 (PDT)
Message-ID: <a3482652-5944-4623-9257-3118aeda4fb1@suse.com>
Date: Fri, 29 May 2026 17:25:24 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: fix incorrect buffered IO fallback for append
 direct writes
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
References: <cover.1779846117.git.wqu@suse.com>
 <54b90ef99f59d9a787e121779ad82b2c77d68466.1779846117.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <54b90ef99f59d9a787e121779ad82b2c77d68466.1779846117.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256540-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: DC6D45FEE59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/5/27 14:36, Qu Wenruo 写道:
> [BUG]
> With the previous bug of short direct writes fixed, test case
> generic/362 (*) will still fail with the following error with nodatasum
> mount option:
> 
>   generic/362  0s ... _check_dmesg: something found in dmesg (see /home/adam/xfstests/results//generic/362.dmesg)
>   - output mismatch (see /home/adam/xfstests/results//generic/362.out.bad)
>      --- tests/generic/362.out	2024-08-24 15:31:37.200000000 +0930
>      +++ /home/adam/xfstests/results//generic/362.out.bad	2026-05-27 10:13:09.072485767 +0930
>      @@ -1,2 +1,3 @@
>       QA output created by 362
>      +Wrong file size after first write, got 8192 expected 4096
>       Silence is golden
>      ...
> 
> *: If the test case has been executed before with default data checksum,
> the failure will not reproduce. Need the following fix to make it
> reliably reproducible:
> https://lore.kernel.org/linux-btrfs/20260526070055.60193-1-wqu@suse.com/
> 
> [CAUSE]
> Btrfs disables page fault in during direct IO write, to avoid a specific
> deadlock that is only specific to btrfs.
> 
> So for the test case generic/362, it will make the direct IO to fail
> with -EFAULT, then we fallback to buffered IO.
> 
> However at btrfs_dio_iomap_begin() -> btrfs_get_blocks_direct_write(),
> we have already updated the isize during extent allocation.
> And if we failed the direct IO, the isize is still the updated one.
> 
> So it means the buffered write will respect the IOCB_APPEND flag and
> write the new data at the update isize, resulting the above failure.
> 
> [FIX]
> Introduce btrfs_dio_data::updated_isize and btrfs_dio_data::old_isize,
> so that if btrfs_get_blocks_direct_write() enlarged the inode size, we
> can know the old inode size.
> 
> Then if we got a short write, and btrfs_dio_data::updated_isize is set,
> then revert to the old isize, so the buffered fallback can write into
> the correct location.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/direct-io.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 598480b77002..24163a4bcfb0 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -15,10 +15,16 @@
>   
>   struct btrfs_dio_data {
>   	ssize_t submitted;
> +	/*
> +	 * If we got a short dio write and @updated_isize is set,
> +	 * revert to the old isize.
> +	 */
> +	loff_t old_isize;
>   	struct extent_changeset *data_reserved;
>   	struct btrfs_ordered_extent *ordered;
>   	bool data_space_reserved;
>   	bool nocow_done;
> +	bool updated_isize;
>   };
>   
>   struct btrfs_dio_private {
> @@ -341,8 +347,11 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>   	 * Need to update the i_size under the extent lock so buffered
>   	 * readers will get the updated i_size when we unlock.
>   	 */
> -	if (start + len > i_size_read(inode))
> +	if (start + len > i_size_read(inode)) {
> +		dio_data->old_isize = i_size_read(inode);
> +		dio_data->updated_isize = true;
>   		i_size_write(inode, start + len);
> +	}
>   out:
>   	if (ret && space_reserved) {
>   		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
> @@ -634,6 +643,10 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>   			 */
>   			btrfs_mark_ordered_extent_truncated(ordered, 0);
>   			btrfs_finish_ordered_extent(ordered, pos, length, true);
> +			if (dio_data->updated_isize) {
> +				i_size_write(inode, dio_data->old_isize);

This part is incorrect, as if we have a short direct write, we can still 
have part of the range written.

In that case we should not revert to the old isize, but to the new 
written size.

Considering we may go several different tries, I think it's better to 
save and set the isize inside btrfs_direct_write(), other than relying 
on the iomap_start/iomap_end() callbacks.

Thanks,
Qu> +				dio_data->updated_isize = false;
> +			}
>   		} else {
>   			btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
>   						pos + length - 1, NULL);


