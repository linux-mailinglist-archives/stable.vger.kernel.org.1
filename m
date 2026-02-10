Return-Path: <stable+bounces-215673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCRSNmFIi2lSTwAAu9opvQ
	(envelope-from <stable+bounces-215673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:01:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246611C34F
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589FA30659CC
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDAD3816ED;
	Tue, 10 Feb 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFoRBQUK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669B3815E1
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735615; cv=none; b=dE1TzTc8pEntTEAPEuNanC7MP5CA9JmIJJ506vbd1hRXzVyt4NgjcLFZzv5hie91SZWfFaCJEv/52Udf82zZfGylpvZhisfvwC5+BI81DEY9ACDOwbUAcb5I0FR6NCF8nlCBGZBOqa4Zz1m19dKncCeW2T5YyWBWPsk1vVkD5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735615; c=relaxed/simple;
	bh=P5N4ABjZx124VekI186qd2AD4yXfKDQt9Vo1Fag6vHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS3OS6kz7VJ3EfC3MSKPDcKcXWkzazsW0Q4E7qOXv/bdAY4M/8aV6qytP7otqZLLUenn32sV/Ru1ozUyQaiSBFZZzjr+q/DfWJKwIEbBPw22TbN0+IK2TYCc//4i4cvuh3yAU66LrknMaxCrhOViU9+o2FRlTIObi1/z6+0BZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFoRBQUK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aadc18f230so17017375ad.3
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770735614; x=1771340414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v436SyFigxsHrmhj471D+104SnMzTMwy4MIHa73zImY=;
        b=gFoRBQUKg+Jbo78iDrELjJ0UCZCUblkzS9MxRPdPYY/sbzRniiq1YIPrnkjYGTzhe/
         22vgvcKY9UueLO/JyQz19mU9CeAdK05ffCOZyY2NXjSSm9wQ6j1P3zvo4pjttVaYo9bJ
         8NYcXQQTnYonQTIlzzRdwR3DHf8b1HIS+cvuWnXROFtqohoGlfkmfQHL52rr0It3rXsp
         ILYBHiGc9WK0eIJMjup0tl3t90UmZ0msyQAAtcrZN26Wh4cBlyvoff/bZhCQ+eoIKTI7
         sdqK3T9oqX4LaxhgNT9KrmcFAFudrlMSOEmRylnCa6AzZvWcMHmd82YrdsAHkIrfjNm/
         I97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770735614; x=1771340414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v436SyFigxsHrmhj471D+104SnMzTMwy4MIHa73zImY=;
        b=gMOnWev8yT3qq6yki58vIP5D9j+kFoVAIuAfqDFWA3jb+BdasWx/k4pMYePdjsOLbv
         O8zok0vHB9SrPLCaIaeHTiOkYaecp71knZ4LVYAmYETVu1E+Q/rk5DTRJq3JkVJp7oxF
         U/l/AIXIe3bbQadMDvH9X+z7a9bvpVE1IYh8w7KEuK5G5T/0q4mKXa0lV3DCd89QaiDS
         Ho1DjXJoJU3MX8u8sa4OuYKJqZUv02aqWJRFH8fGh60ww9MSD1paj/fgiEwfdTHhnhEA
         x+7GU77E2oxMNXQCi4Yp8J7Ux9uIia9gxfQhCUdPVpvJJZ+RuP7P2LjhOesN6Tb1h3ls
         EYxg==
X-Forwarded-Encrypted: i=1; AJvYcCWBG071FromXvWrtjQ9nIFLN/zJUfMPZSiJUyGe6WWs2pMAzaYB4b8MEMwoByN325sKQMlaQ5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tdkuMZDYo168bGu//NcV54gwIiNsneKZqx7yTFW4SJPDXPwL
	SQlqOkh4dGbVglrJ9iHIxU+VsAjk97xXlAX/VGDpjSpdf+gkJyFMsOfA
X-Gm-Gg: AZuq6aIgPkTLcf+yTTezBZ23QWRuOTKkbJ13EEFzu+4LINyD2pQTEJHiZmXLi+e6a12
	bbxIm0S57uLQh2O31NOrKgHm9shaZuP3F+hwNY/gfW9BR74gviUleOvLDgppNAu33RJUcJnr+zR
	7RFj/lvZEQj/IDxNP4VCWW9F2thXbdeJy3h/kp0OMR7loQkNX8wM+D7kyUeySEqRnILMlEojHog
	LdR+S6f9ELri/4d9S3mulhjb0+VzX4HLLEMmxn/Pq6gP69CDlTUGAvPlm+wr+l4IMKX18rXS6ge
	sY/Vrf6rcfHRa5aJxS2BM4gQXMjCWunthXQnEO7V8boGYrW/B0tdI3w3zKu3sRAZGCem879x5Lu
	kv2+pC5rT4v0FO98qMJd0pUpFH0ohYB1ETcHa/zpgiaC1M/olBUb/ZlvuXyAl19gK6aPe7GbvO2
	SRJnZ2whuvMRNsybH6ZeoReR4tyyRm1dnJJw==
X-Received: by 2002:a17:902:e742:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a951643629mr163927435ad.3.1770735613704;
        Tue, 10 Feb 2026 07:00:13 -0800 (PST)
Received: from inspiron ([111.125.237.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aa3ec42e2asm149045835ad.53.2026.02.10.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:00:13 -0800 (PST)
Date: Tue, 10 Feb 2026 20:30:03 +0530
From: Prithvi <activprithvi@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: martin.petersen@oracle.com, d.bogdanov@yadro.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: fix recursive locking in
 __configfs_open_file()
Message-ID: <20260210150003.s55mbwdpgbamjtso@inspiron>
References: <20260205162624.117957-1-activprithvi@gmail.com>
 <20260205192644.GT3183987@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205192644.GT3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215673-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[oracle.com,yadro.com,acm.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3246611C34F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 07:26:44PM +0000, Al Viro wrote:
> On Thu, Feb 05, 2026 at 09:56:24PM +0530, Prithvi Tambewagh wrote:
> 
> > +	r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
> > +	if (r) {
> >  		pr_err("db_root: cannot open: %s\n", db_root_stage);
> >  		goto unlock;
> >  	}
> > -	if (!S_ISDIR(file_inode(fp)->i_mode)) {
> > -		filp_close(fp, NULL);
> > +	if (!d_is_dir(path.dentry)) {
> > +		path_put(&path);
> >  		pr_err("db_root: not a directory: %s\n", db_root_stage);
> > +		r = -ENOTDIR;
> >  		goto unlock;
> >  	}
> > -	filp_close(fp, NULL);
> > +	path_put(&path);
> 
> Just pass it LOOKUP_FOLLOW | LOOKUP_DIRECTORY and be done with the manual
> "is it a directory" tests in any form...

Hello Al,

I sincerely apologise for the delayed response. I was testing the change you 
suggested, however, whenever I tried testing my patch against the latest 
commit where syzbot reported this bug (commit 3a8660878839faadb4f1a6dd72c3179c1df56787
of upstream repository) it gave me a build failure immediately without any
debug log, just the message:

syzbot tried to test the proposed patch but the build/boot failed:

failed to run ["make" "KERNELVERSION=syzkaller" "KERNELRELEASE=syzkaller" "LOCALVERSION=-syzkaller" "-j" "48" "ARCH=x86_64" "bzImage"]: exit status 2

The issue seems to occur multiple times when a patch is tested against the 
latest commit where syzbot reported the issue while it doesn't occur on that 
latest commit of the upstream repository.

However, testing the change on the latest commit of upstream reprository 
(commit 72c395024dac5e215136cbff793455f065603b06) gives a positive result 
that the reproducer doesn't trigger any issue.

Reference: https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#mbf32aeb54c4cae609d3b6176ad8dcd99bfc51ad2

IIUC, since the reported failure appears to be unrelated to the change and is working
successfully on latest commit of upstream, I wanted to confirm if v4 based on 
these findings is acceptable.

What do you think?

Thank you,
Prithvi 

