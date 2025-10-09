Return-Path: <stable+bounces-183704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39467BC96B8
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCF63351242
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038378F59;
	Thu,  9 Oct 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=geoffthorpe.net header.i=@geoffthorpe.net header.b="SUdeUn+I"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C571E47A3
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018697; cv=none; b=PnIKRJ/CdeKfOWqFTRDODiIMzBa+eP0JpInL6MdoN0eU9NWu5XEdjTc6vLxh/p/p1trlF89Ynhm7q12z2uwZ/Euadlajhi5rzzdlN2RQQ5qiJpfGsqkJ/OSKQqItx2Sf+gILzF7vkwhQ1iDXxl+e/1M2w0WGWBl+CqqUQ9vmqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018697; c=relaxed/simple;
	bh=HFz+DzsAHHYBSi6GUFx67A7OgctCJkmIJ99bn/U5o6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAJfK2kdhkE7yojleLHK22c1vKHosAH+Khoisy/mvZ6Xhq9wRS3nVB0DFCVoaiSfI95ofY2RYYJroqdd3HA6QLjThNs/7UxZXeHtikbtpfyQDQr2NV4EPwMDoUo7saRmmG8SexCydvUZyg5pUYCiLNcvJ4vjL1OqCDG9uVNzWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geoffthorpe.net; spf=pass smtp.mailfrom=qclibre.com; dkim=pass (1024-bit key) header.d=geoffthorpe.net header.i=@geoffthorpe.net header.b=SUdeUn+I; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geoffthorpe.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qclibre.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d71bcac45so10816557b3.0
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geoffthorpe.net; s=myprefix; t=1760018694; x=1760623494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdqKy9G6bRtRu/wXq/+0Le+P5mZ0KkhEVzNICvjTdJs=;
        b=SUdeUn+IQi0fAW6YJQxyN+6j7VYVrXng244qtszknaYPUex26olKckKHLqgCl+PcIi
         Tk9uFJ0d6Ie+a4x2yLjV5pr3+CVHkduxnqCDfZebcVrXckBq+qgsqZzgR6fCJEPubatc
         DHufWIRfxWX44Azx9HTNPb+9OlUgE8xXcsM+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018694; x=1760623494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdqKy9G6bRtRu/wXq/+0Le+P5mZ0KkhEVzNICvjTdJs=;
        b=ec+k822zFB4O1xDFM1UPy2a1d2Om9S4a1tS8fiMOP2ANRgvfCmdjKDOanRmehkteNh
         FXHgdA/XcR78wj7abHvqV2sW0zb+B6yZPzjSQtnWtYg5i7s5oyzq+jIVJmAUje+Z/FNU
         M7/twOoy+BZNKD/PQ52PO39xVLjnRr2WBrdYMYDwp/NxJ1/klA4fYkX7qydPj3CoF3G7
         Btq7ZtZYa/wWZxdwq5bJlzDb0auf6bKEaac3oqu8/cfVucOVTpwF6RRzASS01vKcj5SX
         71feWBM/m6USu+JTrnvmQLkQf4MR2poHKIhZ2iWTFZjIzoQjKr5wgfIdX5hkQe9dlPZS
         napg==
X-Forwarded-Encrypted: i=1; AJvYcCV6N1863LY6bPddd6txcHvqcxN74EVkVjO1iEuKqVm5iRN30P5FiZ1hwD8YWdii656DH/c+8rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloGkEJyZBhtBbcWJMlfk2rF25lC8gSKxbqZFHKzW29ArDhXbF
	eMN67jYG+gF5FMRt02OP90GWiNeXIceBj8qme5kHdb/+ePzLei5IKwiIhZJF1I0PI2M=
X-Gm-Gg: ASbGncu8E3s/6gzoljCltDZzDtp9YKa8l+/UDMPz7wWyb5j6U7B/onjxd9bXe6gk05A
	da6qxzIJhO/lZ3VvwXkhjuAN1PiP2WbicG7sxLfNDzhcpn/4OOO6n34zgntvhYlPBd65GinhDfk
	kzXNopZnlhqn9j4PIBqgvn7Rx48TuybM0OkoVnmQ0lWx2iTWayRxA8QtHEYgKw3ZXhNxVD3ODkK
	IOOB8nfXYaDA546Dyx/uskWa8HJoQM4iYG/ZqQ/iPs8hmpXe2ceA90oGVUvLLtQqDfYQnlKN7WT
	GPBrA9uoZtPlEQgl/4orpO59H/vEfFsJKrlF1hhaAtsQ6sNbT5pl8jk/mAlItUNEsCHeNeL3lgG
	i5eY0CJPdZM/Npcw+W9ZkYhsDQvtDOcvB9WNXq40KzO8DdkjylT0RF9oRRXQD8UTEXZSqswcPgF
	i3w27NVgYDiUHnmA==
X-Google-Smtp-Source: AGHT+IEy3Zpk1t7I8Y9go0VYl6eLttKJfqUkxmv9wH5m56XMkNIzUJ4aTQJcvW0kxxWmFap74ApUMg==
X-Received: by 2002:a05:690c:46c5:b0:772:2b5e:1f10 with SMTP id 00721157ae682-780e13f4996mr97210717b3.1.1760018694426;
        Thu, 09 Oct 2025 07:04:54 -0700 (PDT)
Received: from [10.0.0.3] (modemcable155.19-201-24.mc.videotron.ca. [24.201.19.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f2e1db1sm200301485a.4.2025.10.09.07.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:04:53 -0700 (PDT)
Message-ID: <028786fa-8964-4dd1-8721-62a5b757237c@geoffthorpe.net>
Date: Thu, 9 Oct 2025 10:04:52 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression in hostfs (ARCH=um)
To: Hongbo Li <lihongbo22@huawei.com>, stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, regressions@lists.linux.dev
References: <CAH2n15x389Uv_PuQ8Crm7gg4VC0UZ3kJg+eEfHMy8A6rzUtUAA@mail.gmail.com>
 <75a53a17-b5fe-441e-8953-8c1d5e7ca47a@huawei.com>
Content-Language: en-US
From: Geoffrey Thorpe <geoff@geoffthorpe.net>
In-Reply-To: <75a53a17-b5fe-441e-8953-8c1d5e7ca47a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-08 22:42, Hongbo Li wrote:
>
> Hi Geoffrey,
>
> On 2025/10/9 7:22, Geoffrey Thorpe wrote:
>> Any trivial usage of hostfs seems to be broken since commit cd140ce9 
>> ("hostfs: convert hostfs to use the new mount API") - I bisected it 
>> down to this commit to make sure.
>>
>
> Sorry to trouble you, can you provide your information about mount 
> version and kernel version (use mount -v and uname -ar) ?


root@localhost:~# mount --version
mount from util-linux 2.41 (libmount 2.41.0: selinux, smack, btrfs, 
verity, namespaces, idmapping, fd-based-mount, statmount, statx, assert, 
debug)

As for the kernel version, I have been bisecting different kernel 
versions to find the culprit commit. The problem occurs with the commit 
id I mentioned (cd140ce9: "hostfs: convert hostfs to use the new mount 
API"). This appears to be between v6.10 and v6.11. The most recent 
kernel releases all seem to exhibit the problem. My own code has been 
using kernel v6.6 up till now and that works fine.

By the way, did you try using the steps to reproduce? No pressure to do 
so, I am just curious if the instructions I provided work OK for other 
people (or whether I missed something essential). If you do follow those 
steps, you should be able to see success if you use v6.6 or older, and 
you should see failure with anything newer.

(Side note: when bisecting, I noticed that a number of commits had to be 
skipped because they seg-faulted during early boot. Fortunately, that 
didn't prevent me from finding the culprit. I mention this just in case 
you stumble across a commit that seg-faults too - it appears that's 
unrelated to the current regression.)

Regards,
Geoff



