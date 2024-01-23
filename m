Return-Path: <stable+bounces-15475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848083859B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A41C2A8B0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94352F8A;
	Tue, 23 Jan 2024 02:36:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B652F90
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977381; cv=none; b=cC1DlgX1a6Gdu+j4DUUirL/yZgqZQUPpHXN9qO/xS4R3p+Eac2L1QkBYMjltmu97fngOXXZoidpbdSis3NUKgnfXcDgjftDXNGVtV3QReMDka90gbQpF46TXrlFfzYRfBSMb7FNstCYsQdQDyc9d4vG1yHlPyxNWs0xDzxcnQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977381; c=relaxed/simple;
	bh=zNxDVW38JyLg3jZ1PcNm18UbP3pEowtjd0NZBk51UKs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CdVmu4wxjC8SRXzgg6l8gDw5H5i0eg/qwMaYoRPAib6kq/vvTsEuakl9DI83DWWc7XsE2/vs1mjpOvrgNv5mU+OTamISh2MkVn4H5+S0ADkqh5dGiHK6W0lq/QiaUziYbsN7obJdWwk/JGl1PQKOjn/TgVYviJeGfviuWb/bkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TJrmp4ZGBz1wnBJ;
	Tue, 23 Jan 2024 10:35:54 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 23122140416;
	Tue, 23 Jan 2024 10:36:16 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 10:36:15 +0800
Subject: Re: [PATCH 01/15] ubifs: Set page uptodate in the correct place
To: Matthew Wilcox <willy@infradead.org>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<stable@vger.kernel.org>
References: <20240120230824.2619716-1-willy@infradead.org>
 <20240120230824.2619716-2-willy@infradead.org>
 <5ad7b6ed-664b-7426-c557-1495711a6100@huawei.com>
 <Za5-UJU0tqT9CYQj@casper.infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f96965c0-8464-c12c-7e5c-95ba74d10b7d@huawei.com>
Date: Tue, 23 Jan 2024 10:36:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Za5-UJU0tqT9CYQj@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/1/22 22:40, Matthew Wilcox 写道:
> On Mon, Jan 22, 2024 at 03:22:45PM +0800, Zhihao Cheng wrote:
>> 在 2024/1/21 7:08, Matthew Wilcox (Oracle) 写道:
>>> Page cache reads are lockless, so setting the freshly allocated page
>>> uptodate before we've overwritten it with the data it's supposed to have
>>> in it will allow a simultaneous reader to see old data.  Move the call
>>> to SetPageUptodate into ubifs_write_end(), which is after we copied the
>>> new data into the page.
>>
>> This solution looks good to me, and I think 'SetPageUptodate' should be
>> removed from write_begin_slow(slow path) too.
> 
> I didn't bother because we have just read into the page so it is
> uptodate.  A racing read will see the data from before the write, but
> that's an acceptable ordering of events.
> .
> 

I can't find where the page is read and set uptodate. I think the 
uninitialized data can be found in following path:

       writer               reader
ubifs_write_begin
  page1 = grab_cache_page_write_begin
  err = allocate_budget // ENOSPC
  unlock_page(page1)
  put_page(page1)
  write_begin_slow
   page2 = grab_cache_page_write_begin
   SetPageChecked(page2)
   SetPageUptodate(page2)
                 generic_file_read_iter
                  filemap_read
                   filemap_get_pages
                    filemap_get_read_batch
                    if (!folio_test_uptodate) // page2 is uptodate
                   copy_folio_to_iter // read uninitialized page content!
copy_page_from_iter_atomic // copy data to cover uninitialized page content

