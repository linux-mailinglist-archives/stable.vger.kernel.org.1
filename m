Return-Path: <stable+bounces-108350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED7A0AD70
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 03:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC0618864AA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF742A87;
	Mon, 13 Jan 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIppyEQ1"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0591CA6F
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735748; cv=none; b=Scad33JH3LIZrbB2bMhkUx71CPTtXkuroTf81lsIjlWJjjmD75hlvPzbXoLnv2SOdFgU20MTbCN117JnXjfQNCCpeFU/VHBOlIHBJd5h4c32mrItFcKbLLPW2iJAnIv/eGSNe6291q+so1BdNVQwuUiw+9CELTzw4IwpbC94wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735748; c=relaxed/simple;
	bh=S2dyKJGoDwdE5JsRwuw6bMGnzgF/CnDI+xsDDxGuiiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws8KzQCC+noxG2osUUiV97tAxu3l7CXZy0IQEq29mSV+dA0eARqPmqbG2Kk7QcY3H13XGzUcxrUGDrPPP9/6r5CN9LcsYBAyB9h+m9UfC0RLiA3z4NZLlBoVIStZB2cFva160vNRkmhOdcUPKGy10FH1AxwCYm+maok1SQBaVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIppyEQ1; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e5ab96b-2a2a-4e64-b0e0-2fdf6ce39810@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736735734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyO/9RMXYmH7PS4UYywZFE+3yycYUBBK8G/Qg9/NitY=;
	b=uIppyEQ1UjW3FUU6dlXaueK+HfeRRY2fPgnXuEUs7093Q8xteIBUek1LEsK7pG9k5KpPtx
	SW/RpYv2BY+te9X75JQjW4A9DoiA31IE+dmforC/IHdTcEzuAYXgEN1bRjjeIbdBhXZjuY
	vuu2EPuW0V+AkSUqYFivVDAncdhPZC0=
Date: Mon, 13 Jan 2025 10:34:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tools: fixed compile tools/virtio error "__user"
 redefined [-Werror]
To: Greg KH <gregkh@linuxfoundation.org>, Yufeng Wang <wangyufeng@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Tony Ambardar <tony.ambardar@gmail.com>,
 Alexander Potapenko <glider@google.com>, Uros Bizjak <ubizjak@gmail.com>,
 Shunsuke Mie <mie@igel.co.jp>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250109084341.477226-1-wangyufeng@kylinos.cn>
 <2025010943-chess-affluent-1bb5@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <2025010943-chess-affluent-1bb5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Greg and Yufeng


On 2025/1/9 17:14, Greg KH wrote:
> On Thu, Jan 09, 2025 at 04:43:41PM +0800, Yufeng Wang wrote:
>> we use -Werror now, and warnings break the build so let's fixed it.
>>
>> from virtio_test.c:17:
>> ./linux/../../../include/linux/compiler_types.h:48: error: "__user" redefined [-Werror]
>> 48 | # define __user BTF_TYPE_TAG(user)
>> |
>> In file included from ../../usr/include/linux/stat.h:5,
>> from /usr/include/x86_64-linux-gnu/bits/statx.h:31,
>> from /usr/include/x86_64-linux-gnu/sys/stat.h:465,
>> from virtio_test.c:12:
>> ../include/linux/types.h:56: note: this is the location of the previous definition
>> 56 | #define __user
>>
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
>> ---
>>   include/linux/compiler_types.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> index 5d6544545658..3316e56140d6 100644
>> --- a/include/linux/compiler_types.h
>> +++ b/include/linux/compiler_types.h
>> @@ -54,6 +54,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>>   # ifdef STRUCTLEAK_PLUGIN
>>   #  define __user	__attribute__((user))
>>   # else
>> +#  undef __user
>>   #  define __user	BTF_TYPE_TAG(user)
>>   # endif
>>   # define __iomem
>> -- 
>> 2.34.1
> What commit does this fix?  Why is this suddenly showing up now?
>
> thanks,
>
> greg k-h


This may be an issue caused by an upgrade in the GCC version.

Using GCC version 9.3.0, it can happily pass the build process.

However, when using GCC version 12.3.1, issues arise.

The initial build error stack is as follows:

cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I 
../../usr/include/ -Wno-pointer-sign -fno-strict-overflow 
-fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include 
../../include/linux/kconfig.h -mfunction-return=thunk 
-fcf-protection=none -mindirect-branch-register -pthread   -c -o 
virtio_test.o virtio_test.c
In file included from ./linux/compiler.h:5,
                  from ./linux/kernel.h:12,
                  from ./linux/scatterlist.h:4,
                  from ./linux/virtio.h:4,
                  from ./linux/virtio_config.h:5,
                  from ../../usr/include/linux/vhost_types.h:14,
                  from ../../usr/include/linux/vhost.h:14,
                  from virtio_test.c:17:
./linux/../../../include/linux/compiler_types.h:57: error: "__user" 
redefined [-Werror]

    57 | #  define __user        BTF_TYPE_TAG(user)
       |
In file included from ../../usr/include/linux/stat.h:5,
                  from /usr/include/bits/statx.h:31,
                  from /usr/include/sys/stat.h:465,
                  from virtio_test.c:12:

../include/linux/types.h:56: note: this is the location of the previous 
definition

    56 | #define __user

It should have first encountered the following #ifndef

https://elixir.bootlin.com/linux/v6.12.5/source/tools/include/linux/types.h#L52

So I think the  modification should be as follows(Adjust the position of 
the header file),

What do you think?


diff --git a/tools/virtio/linux/virtio_config.h 
b/tools/virtio/linux/virtio_config.h
index 42a564f22f2d..3d32211d2d23 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -1,8 +1,8 @@
  /* SPDX-License-Identifier: GPL-2.0 */
  #ifndef LINUX_VIRTIO_CONFIG_H
  #define LINUX_VIRTIO_CONFIG_H
-#include <linux/virtio_byteorder.h>
  #include <linux/virtio.h>
+#include <linux/virtio_byteorder.h>
  #include <uapi/linux/virtio_config.h>

  struct virtio_config_ops {
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 028f54e6854a..8cbe632e98b0 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -9,13 +9,13 @@
  #include <assert.h>
  #include <unistd.h>
  #include <sys/ioctl.h>
+#include <linux/virtio.h>
  #include <sys/stat.h>
  #include <sys/types.h>
  #include <fcntl.h>
  #include <stdbool.h>
  #include <linux/virtio_types.h>
  #include <linux/vhost.h>
-#include <linux/virtio.h>
  #include <linux/virtio_ring.h>
  #include "../../drivers/vhost/test.h"

Thanks

Best Regards

Hao


