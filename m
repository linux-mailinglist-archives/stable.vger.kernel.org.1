Return-Path: <stable+bounces-254239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHstIpwOFWrVSQcAu9opvQ
	(envelope-from <stable+bounces-254239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 05:08:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611225D03A0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 05:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD8DE3009CC8
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 03:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462427083C;
	Tue, 26 May 2026 03:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uISjatNo"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344C3911DD;
	Tue, 26 May 2026 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764885; cv=none; b=tT3dN3rIWwgIGqH25SSvmK54lRAxRxJOY9xC5YUjp56sU3XqmTa6jp3am5HuX4foQc0Ws8TVnLTRB0aUDZz5bRxS30Mf4MrrYWJTj8M0CgEwIRD4DdHWYepPl4/9VwrHIcPbh6MeHVHcJ8guf9LYusK8MnS75vc2uCU9FC1bUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764885; c=relaxed/simple;
	bh=ksDO1gcnq/lVhe9THFdc8JsXrZ7A4pyOjaGctWemHHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u89wIV3EGfGs0Reh0HVvuMdVyMrcehihRA0qDmKxGLLavh/43v5oENIS3mDHraMY8jEr6UkzX2Isg+YSx6uehC78+mN0v6rPJ0PQrDqCvNFyQzNCRLz4iw6NLUxfyy+aYJ5gw9rW/VKi279l5dg/NDGemFogEN+1ZHHYVqz27CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=uISjatNo; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779764869;
	bh=Hg358ENkRhAGDq3t9ESmdWGtTOyacJe+2JcTPkeT404=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uISjatNogRRVmtOBCbmw9vZbyLKvmwa8C0Olh0EmHPNyz7v7iD18uYHEkclo15T6K
	 ERYqK8jPFyfAC1F8SAYnMIB8zESKZvih866Zd146BdqPNbp8mGFZ7Pfdx4UzE+/Byj
	 y2q8L0BG7gMHY2RiTiop+j9c2XsHJpCU76F25msM=
Received: from [192.168.1.40] ([183.241.55.175])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 1EE3C409; Tue, 26 May 2026 11:07:46 +0800
X-QQ-mid: xmsmtpt1779764866t2kgw90pu
Message-ID: <tencent_8D358C1F4992EDD688387C30330D18B45608@qq.com>
X-QQ-XMAILINFO: MvUAcPkRmFBfqIkcmIQdNh/ZDGvbu1DgshddzZNkxpfryWJtsVetBbcH/c+Ul2
	 MKeghGOMV9bwbSLxCfo2oJM6gUj3bhUD+wK+6RQK3teR9NS8lMdX+Npke0jm02mKvvyGIRCXlgTc
	 NaM8cKy6A7hj6TZvo0AUBEY2DqDV+r9aq5cTggcf11wj+PQRzjjPHQGHMmvIaP9tAfsddflppP85
	 HCwN2CjNyvH0ioAfu7TclCaYBV2fpbAUrM8yZhC9ww82rm9pCl0iWbAPlKFHM6TBQsag8fK41JpK
	 oADOX54JcglDNZXwgGl5pVhD6lh3IndKXo34dFlyIt/3ZcWO6GOXlZ6r9Pe4uAU8NNmdLTAxIc7s
	 j/mC7o9VWcObqkfwJ1IDOsFqXlffzQuNjQzPuz7TeW8J6/Lyc6+0FRI/2Su7C4ZjVF8Pf9WwjMv4
	 wLNPRQ+jtvAY/WF3vMl/qx3h6pEk/HUAdEGa+W0FIjCYbDfaXySU9R7sPXRknE+uu7nh+NB23TGC
	 mvMay9PYBFiEfl3uz4myKfjZpyXtQDFGDf1tTHFLv3JXPjydH+AEEdhT7IMIYefyDPRbfkfGF8UP
	 W6U03LCYUGCxKe+bHhIxiWNNwuou4NdXKdN+ALhKq0QcJbh0mqbtficQF1fTo65bPrNsDam9tqqp
	 C/01xhPEmXwvsRXNNp/GQkBxozhG96bEmB6IV17noB/aIgNEEfDeGL9w2Ldmm5HmFcwScL8dsYq3
	 rYggu9tfASRiqrItHaSX/KS2F4yUSAuQyZf/5Ls48nybkZnbvtIdZP4yonhvReRCmvmM0x1bdeNv
	 G0FnIlMB99bkHwCiZx8Jnyyobown0Il3quP6i45T404qmYHCcM7cvUfL/+5r63wxwdkVWPYGPw4X
	 ExKM9Pznm5H48fRIjoebBTBX/ijcVYhLahgM0X2c8//SZsk3I48XCGx1DirBkQu7sHljMb09ietQ
	 9eNSWpOBVoXmr98kGnRsq4J08LT7Ew1OvU4oB1L3GKlLrdOTKMC5HhqmxBVT+MoOJao3OYfODPvf
	 IH9wY7o0WN/f6XU6qOJ/QsoRFRXjxvR8khzocKZLdcO8bJy/8IU1XaZOnpENGT8Xv93rl7LdlDm0
	 WV4C4dx9rcOtv0NWjQTpLQKY+How==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <3a7d3e16-602e-42d4-b889-6e2d274059ea@foxmail.com>
Date: Tue, 26 May 2026 11:07:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y v2 2/3] ksmbd: add durable scavenger timer
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, stfrench@microsoft.com, d.ornaghi97@gmail.com,
 knavaneeth786@gmail.com
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
 <20260525104130.1252-1-alvalan9@foxmail.com>
 <tencent_88A30183B6BDC6E9A34612CF7A10071E4605@qq.com>
 <CAKYAXd_=z9THUikoBQnCCMcq2yoA14RdwTWNS+4eQWSiSQMfKA@mail.gmail.com>
From: Alva Lan <alvalan9@foxmail.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd_=z9THUikoBQnCCMcq2yoA14RdwTWNS+4eQWSiSQMfKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254239-lists,stable=lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,microsoft.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[foxmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qq.com:mid,foxmail.com:dkim]
X-Rspamd-Queue-Id: 611225D03A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/26/2026 10:22 AM, Namjae Jeon wrote:
> @@ -817,6 +968,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work
> *work, struct ksmbd_file *fp)
> }
>              up_write(&ci->m_lock);
> +           fp->f_state = FP_NEW;
>               __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
> You seem to have missed this change above.
I remove this line for:
fp->f_state = FP_NEW was moved the beginning of ksmbd_reopen_durable_fd ()
in upstream commit 235e32320a47 ("ksmbd: fix use-after-free in 
__ksmbd_close_fd() via durable scavenger")
in v7.1. This upstream commit 235e32320a47 have been backported into 
v6.6 [1] before this patch,
some code snippets:
@@ -855,9 +867,23 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work 
*work, struct ksmbd_file *fp)
          return -EBADF;
      }

-    fp->conn = work->conn;
+    old_f_state = fp->f_state;
+    fp->f_state = FP_NEW;
+    __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+    if (!has_file_id(fp->volatile_id)) {
+        fp->f_state = old_f_state;
+        return -EBADF;
+    }
+
+    fp->conn = conn;
      fp->tcon = work->tcon;

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=0000a7780e0e446a28a273572f6ea8f7f582f694


>
>>   int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
>> @@ -934,6 +1085,8 @@ int ksmbd_init_file_cache(void)
>>          if (!filp_cache)
>>                  goto out;
>>
>> +       init_waitqueue_head(&dh_wq);
>> +
>>          return 0;
>>


