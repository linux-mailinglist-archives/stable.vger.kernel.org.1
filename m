Return-Path: <stable+bounces-203042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61295CCE47C
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 03:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 636CF3017384
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B60B27A477;
	Fri, 19 Dec 2025 02:40:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673F258CE5;
	Fri, 19 Dec 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112019; cv=none; b=NuzV4d1D8nNLR6FidTqRvyqBpYXzGpo2YBJKkCx4lG9QCQBKinmbRADTUl5+9oit8OGtRzV6omvqSPrLjBsA2edGjClOLwHbQJ4CJZdOAAyaq4eErHJftbtTx17ZLTG7h6uCOgbT1cASSlPPlbi9iJwpJLJ8F4+Nvf5Khxsb5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112019; c=relaxed/simple;
	bh=jLo+9GzO2eKFFyAxjJxsT9oTAZ0wrblV399Te4BvM2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XEskMOhdCUVnQFCIsdQpHLsobAgM1n0qg0Eu7fZL5fYjrFgF8wHMcCd75gMedgHnDgIr7cwjUYhlyudVxM4nkOshuqgaV2RkeIo1JajU+lqwNXobOyMPBgfdaOTUGvV1LFEfr083VJz2PAsJuFGpZxgYgiuLn0qaC7bo3LodXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAAHKeD1ukRpAMAsAQ--.24254S2;
	Fri, 19 Dec 2025 10:40:03 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jie.gan@oss.qualcomm.com,
	leo.yan@arm.com,
	james.clark@linaro.org
Cc: akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	make24@iscas.ac.cn,
	mathieu.poirier@linaro.org,
	mike.leach@linaro.org,
	stable@vger.kernel.org,
	suzuki.poulose@arm.com
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak in etm_setup_aux
Date: Fri, 19 Dec 2025 10:39:49 +0800
Message-Id: <20251219023949.12699-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
References: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
X-CM-TRANSID:rQCowAAHKeD1ukRpAMAsAQ--.24254S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xCrykZF4kAF17XrykGrg_yoW5XrWrpr
	WUGay5trWDGF10k392qw15Z3yI93ySyrsagr4fGrnxuw1Yqr9IvryjqrWF9Fn3CrWkJr10
	qw12qayxZFWUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On 12/15/2025 10:09 AM, Jie Gan wrote:
> On 12/15/2025 5:51 PM, Leo Yan wrote:
>> On Mon, Dec 15, 2025 at 11:02:08AM +0200, James Clark wrote:
>>>
>>>
>>> On 15/12/2025 04:27, Ma Ke wrote:
>>>> In etm_setup_aux(), when a user sink is obtained via
>>>> coresight_get_sink_by_id(), it increments the reference count of the
>>>> sink device. However, if the sink is used in path building, the path
>>>> holds a reference, but the initial reference from
>>>> coresight_get_sink_by_id() is not released, causing a reference count
>>>> leak. We should release the initial reference after the path is built.
>>>>
>>>> Found by code review.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
>>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>>> ---
>>>> Changes in v2:
>>>> - modified the patch as suggestions.
>>>
>>> I think Leo's comment on the previous v2 is still unaddressed. But releasing
>>> it in coresight_get_sink_by_id() would make it consistent with
>>> coresight_find_csdev_by_fwnode() and prevent further mistakes.
>> 
>> The point is the coresight core layer uses coresight_grab_device() to
>> increase the device's refcnt.  This is why we don't need to grab a
>> device when setup AUX.
>
> That make sense. We dont need to hold the refcnt for a while and it 
> should be released immediately after locating the required device.
>
> Thanks,
> Jie

>> 
>>> It also leads me to see that users of coresight_find_device_by_fwnode()
>>> should also release it, but only one out of two appears to.
>> 
>> Good finding!
>> 
>> Thanks,
>> Leo
>> 
Hi all,

Thank you for the insightful discussion. I've carefully read the 
feedback from Leo, James, and Jie, and now have a clear understanding 
of the reference count management.

The core issue: coresight_get_sink_by_id() internally calls 
bus_find_device(), which increases reference count via get_device().

From the discussion, I note two possible fix directions:

1. Release the initial reference in etm_setup_aux() (current v2 patch)
2. Modify the behavior of coresight_get_sink_by_id() itself so it 
doesn't increase the reference count. 

Leo mentioned referencing how acpi_dev_present() does it, and James 
also pointed out that APIs should be consistent. I think it makes 
sense that following the principle like "lookup doesn't hold a 
reference" could prevent similar leaks in the future.

To ensure the correctness of the v3 patch, I'd like to confirm which 
patch is preferred. If option 2 is the consensus, I'm happy to modify 
the implementation of coresight_get_sink_by_id() as suggested.

Looking forward to your further guidance.

Thanks!


