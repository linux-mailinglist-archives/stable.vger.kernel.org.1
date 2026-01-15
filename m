Return-Path: <stable+bounces-208389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D6D21E0E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE6823010AA6
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F01A2C11;
	Thu, 15 Jan 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IXRmJgeO"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0063D76;
	Thu, 15 Jan 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437801; cv=none; b=bBrkuvPhf/UI/NxXLXSdeL/fW5jn1dXQg4o1uaaXwBrgp+OPbh6spmqONDirYUS5MUY4i5cuQeK2R1t16I3Gx/eGLczBXdHgjGs8r2N8n+NtygnYphDxOmwG0vNTzQUKONHG9OyK4gZZGXDcCRkV7BGeTFwyH/WGN4dY0M77v4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437801; c=relaxed/simple;
	bh=Fc33RkLkjHD3KToYwOX2/sMU2WXz7e3DfW6v2CPHymI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F40oMIVC/7MryGA2zv2gA8NORI3rseXZVTz9lgJXzcpLtMaOy1OwGt3umfdVUSDWBevxsMrIAFcIkGII65gYAALMNPPB6q1BtHSpsvTCh0GG+B1kNNGcMjbmTRLJcb+ohYgo2XzN1BVBWj8HB0T8PD29yZyywHomEs5AYuLrwmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IXRmJgeO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Xh42m2LUwLT4sb748BpO/fu2qZRhBc7yNgZM4yJFUM0=; b=IXRmJgeOZdjHBHW25otBCHqNSb
	q+v9FwM9cbPMNq5XH4kKXOrODdEBr04QdI5C0V/dt+UD6nmCZoF1ejJHVwlJy/h+1LPheylWmwdkC
	GyXDtYSbUy8mhy+NXbFbKnAdkDwq7kxI5J5m7yq1nj3dwCK3JAgvkGYswenSjJbuWdZPvAVhNViRe
	J5sgQa+wjSzP6tjx6lzNcmEcEJfa1oDcyFEwLCZLe+ofh+XnNGbMu7ivNTjKKE9KFZB1Os/ZJY/je
	+coRKvm9au/3or5JbPnuOpC2WQqP7frjXa8xYX0ckFpfztXYKYcTeWXhuA3uTgQSfgOAtPLrgTS9k
	xFyepITA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgBSI-0000000BGkz-0uzb;
	Thu, 15 Jan 2026 00:43:18 +0000
Message-ID: <79bb75da-5233-46d8-9590-7443806e2bd7@infradead.org>
Date: Wed, 14 Jan 2026 16:43:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] scripts/kernel-doc: avoid error_count overflows
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 stable@vger.kernel.org
References: <cover.1768395332.git.mchehab+huawei@kernel.org>
 <68ec6027db89b15394b8ed81b3259d1dc21ab37f.1768395332.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <68ec6027db89b15394b8ed81b3259d1dc21ab37f.1768395332.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Mauro,
The line formatting is weird on one line below
(looks like 2 text lines are joined).

On 1/14/26 4:57 AM, Mauro Carvalho Chehab wrote:
> The glibc library limits the return code to 8 bits. We need to
> stick to this limit when using sys.exit(error_count).
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  scripts/kernel-doc.py | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> index 7a1eaf986bcd..3992ca49d593 100755
> --- a/scripts/kernel-doc.py
> +++ b/scripts/kernel-doc.py
> @@ -116,6 +116,8 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
>  
>  sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
>  
> +WERROR_RETURN_CODE = 3
> +
>  DESC = """
>  Read C language source or header FILEs, extract embedded documentation comments,
>  and print formatted documentation to standard output.
> @@ -176,7 +178,20 @@ class MsgFormatter(logging.Formatter):
>          return logging.Formatter.format(self, record)
>  
>  def main():
> -    """Main program"""
> +    """
> +    Main program
> +    By default, the return value is:
> +
> +    - 0: success or Python version is not compatible with                                                                kernel-doc.  If -Werror is not used, it will also

Here ^^^^^

> +       return 0 if there are issues at kernel-doc markups;
> +
> +    - 1: an abnormal condition happened;


-- 
~Randy


