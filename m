Return-Path: <stable+bounces-87-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FF7F67FF
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 21:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893742812B2
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46784D134;
	Thu, 23 Nov 2023 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IqpZ0VR4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A7D47
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:04:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso292722b3a.0
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700769844; x=1701374644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/WfHWKDW3LuB/2tH5rrGpk3IkHtZyi5i7bzkP0nzIk=;
        b=IqpZ0VR4wjLxxY8xCWNegkoZpS10S+2UhaT/eAPWNkxofnOgmqjOE2K8Cz9GlmtR8Q
         tbxnjGEVO3Lb75AroPUo8c2tVOJX7HtA2UzGJnxLfkzi6XmW9AdNoDflyYw+mtNbDz/5
         WkgNkueKL8PzY4ZZi8CtcSLq9e2CBWQPdk9a4Mlo2spImKFmoARY2u1xqL8hRIXTOjNE
         7DV9GmIto+zxp/sl6gzxOy9OpipKDUkZExwKYdOg7foQSIXvy4bqEKjFJtG2LVhQFcfz
         AQesjHRB3nv44oVksZ4y+apNUp/PKBhrrJ3YYwFj3LcKKPX5Tdd+YFjKI2M/jUIFePqv
         HJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769844; x=1701374644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/WfHWKDW3LuB/2tH5rrGpk3IkHtZyi5i7bzkP0nzIk=;
        b=pi5JRARqtbD1W9IY9YbdJw+XJeIdL851E4awgqu+TbQvEbf7zp+5m3K67s6N730ope
         Ysp0ZNWXrtxQW2b1jnX5xWP8JenXNZznXkneK96lVxBHDEJUfAPbPsKoUQx1DMGIPPEq
         8OYKnC1sGHn3rriHDTNZ9cXh4CsOMfhqUWJ0BGVIvuecWrXXeC3Ust1lsnxFSdiprOAb
         52BYmYMp/cPyMn9AFe/l+xmu7K4PACDdoFD7Fvs46JYvk/eKdqArS+YhhmFIsQuGSR07
         afWoBHWjjdPIedQCpGRcxjKEDcmlqeNEUoZEzbbDZREXGzUfQtFSUm2MRgKJpf0eWs0f
         Tdsg==
X-Gm-Message-State: AOJu0YxmqNWGF9kj9KHeXCt5tqAqX5abKZ4O1CXWimM9rOg698neriA5
	wa1PjX2o6wRgH53Hx04Uq2yhrA==
X-Google-Smtp-Source: AGHT+IHOsETM6ubQBxOsCUwHnVNtbPNzAzdYNcu/mic2bqqRB0wc1z/0IBofXl3irDzN5mAxRUc6DQ==
X-Received: by 2002:a05:6a20:8f18:b0:186:10ae:152a with SMTP id b24-20020a056a208f1800b0018610ae152amr792987pzk.4.1700769844215;
        Thu, 23 Nov 2023 12:04:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b006c0316485f9sm1604516pfa.64.2023.11.23.12.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:04:03 -0800 (PST)
Message-ID: <2f3bf38b-a803-43e5-a9b9-54a88f837125@kernel.dk>
Date: Thu, 23 Nov 2023 13:04:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: target: core: add missing file_{start,end}_write()
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
 David Howells <dhowells@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20231123092000.2665902-1-amir73il@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231123092000.2665902-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/23 2:20 AM, Amir Goldstein wrote:
> The callers of vfs_iter_write() are required to hold file_start_write().
> file_start_write() is a no-op for the S_ISBLK() case, but it is really
> needed when the backing file is a regular file.
> 
> We are going to move file_{start,end}_write() into vfs_iter_write(), but
> we need to fix this first, so that the fix could be backported to stable
> kernels.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



