Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A47314F9
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 12:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbjFOKOi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 06:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbjFOKOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 06:14:37 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D04B2710
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 03:14:36 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxzOqL5IpkZYUFAA--.11823S3;
        Thu, 15 Jun 2023 18:14:35 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMqK5Ipk_dobAA--.4752S3;
        Thu, 15 Jun 2023 18:14:34 +0800 (CST)
Subject: Re: [PATCH 06/10] cifs: release leases for deferred close handles
 when freezing
To:     zybsyzlz@163.com
Cc:     Steve French <stfrench@microsoft.com>,
        David Howells <dhowells@redhat.com>, stable@vger.kernel.org
References: <20230615094848.24975-1-zhuyinbo@loongson.cn>
 <20230615094848.24975-6-zhuyinbo@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <b864d7a6-e464-950d-b0dc-d6b230308153@loongson.cn>
Date:   Thu, 15 Jun 2023 18:14:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230615094848.24975-6-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTMqK5Ipk_dobAA--.4752S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Sorry to bother you. This is an incorrect send, please ignore it.


ÔÚ 2023/6/15 ÏÂÎç5:48, Yinbo Zhu Ð´µÀ:
> From: Steve French <stfrench@microsoft.com>
> 
> We should not be caching closed files when freeze is invoked on an fs
> (so we can release resources more gracefully).
> 
> Fixes xfstests generic/068 generic/390 generic/491
> 
> Reviewed-by: David Howells <dhowells@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>   fs/cifs/cifsfs.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 8b6b3b6985f3..43a4d8603db3 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -760,6 +760,20 @@ static void cifs_umount_begin(struct super_block *sb)
>   	return;
>   }
>   
> +static int cifs_freeze(struct super_block *sb)
> +{
> +	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
> +	struct cifs_tcon *tcon;
> +
> +	if (cifs_sb == NULL)
> +		return 0;
> +
> +	tcon = cifs_sb_master_tcon(cifs_sb);
> +
> +	cifs_close_all_deferred_files(tcon);
> +	return 0;
> +}
> +
>   #ifdef CONFIG_CIFS_STATS2
>   static int cifs_show_stats(struct seq_file *s, struct dentry *root)
>   {
> @@ -798,6 +812,7 @@ static const struct super_operations cifs_super_ops = {
>   	as opens */
>   	.show_options = cifs_show_options,
>   	.umount_begin   = cifs_umount_begin,
> +	.freeze_fs      = cifs_freeze,
>   #ifdef CONFIG_CIFS_STATS2
>   	.show_stats = cifs_show_stats,
>   #endif
> 

