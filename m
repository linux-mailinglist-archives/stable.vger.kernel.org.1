Return-Path: <stable+bounces-208324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644AD1CB31
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B06F300D410
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7936C5A7;
	Wed, 14 Jan 2026 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zn/1Iqu3"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9736C5BB;
	Wed, 14 Jan 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372945; cv=none; b=Ai59OsHIwReGdtAXYZwVW8vb1wkbVV/lJD8qzDedhwTl9xC57rKJcvxZVdMVBEE27jwvi9vx0hn3dCQ0JHCVtN/eLAevXVhSi4+PAy2eG+VGWUN2mxRBXR+1WelN26DQ1rl4JbGMgZnGb+X/v4IFxBI1yKXTO+egK7c0t0lg0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372945; c=relaxed/simple;
	bh=iiuFnbFRuv6lEhKDArUISVQPynMG6wSyW8BS55K2Kzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O01j+8oAB0urW+RM3N/4c32yQGUJx4VggqVYlngPfIrcot6oeTyu1//YGj9SVtjfLlk1sWmGsOtd4F0Y0hcU8iZ3EnSP6HplBR3hV9u6+CZGKhW0QkzrtdM8TdXwfg5mvOiruRWRYenFpaVxYyt107uhskXhUAHgrOacy1mnjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zn/1Iqu3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ScN+Ac0MsYE0ns/Mmofc+hTGIotZQRuqma1Uz6SovDM=; b=Zn/1Iqu3fgOSmkufa8/TacqqiB
	Gtftep0tiOh6T2nhr/GcwgjmV2NtMpSKlVPgQy6vciVoea7lDHyUKHOAMidgeDHhfyDeUokuMqa0G
	Fg3EfQuRcaHmu/U+WiXsL2w1MRaOMQIcPQMVQiN2XuaXbzxp7TX/+yia8KKxKVZ9tDkmQ2quGVngQ
	Gy3k4Oe/bIQ2TUO20v4wC+6r4u20EDJPbtLMiW4hED6PQo91FPZ2TVEHcd5c9QcUvoDUEPQMG0oeE
	IebSmrIuEEadZUA8k8KRI+/xq8hPLOw+vn3X40P9JGLhJvvaWXSo2fZ0I5CtSQF/V1MW/iV1dBr9T
	HRI0CDug==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfua2-000000088fE-1p4Y;
	Wed, 14 Jan 2026 06:42:10 +0000
Message-ID: <0eadb091-2a5c-402b-908a-7f069c115c9f@infradead.org>
Date: Tue, 13 Jan 2026 22:42:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] scripts/kernel-doc: avoid error_count overflows
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 stable@vger.kernel.org
References: <cover.1768324572.git.mchehab+huawei@kernel.org>
 <80bd110988b8c1bd1118250c2acc05e9d2241709.1768324572.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <80bd110988b8c1bd1118250c2acc05e9d2241709.1768324572.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/26 9:19 AM, Mauro Carvalho Chehab wrote:
> The glibc library limits the return code to 8 bits. We need to
> stick to this limit when using sys.exit(error_count).
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  scripts/kernel-doc.py | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> index 7a1eaf986bcd..5d2f29e90ebe 100755
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
> @@ -176,7 +178,21 @@ class MsgFormatter(logging.Formatter):
>          return logging.Formatter.format(self, record)
>  
>  def main():
> -    """Main program"""
> +    """
> +    Main program
> +    By default, the return value is:
> +
> +    - 0: parsing warnings or Python version is not compatible with
> +      kernel-doc. The rationale for the latter is to not break Linux
> +      compilation on such cases;

    Does "parsing warnings" mean that there were no errors, just possibly
    warnings or possibly nothing, i.e., all clean?

> +
> +    - 1: an abnormal condition happened;
> +
> +    - 2: arparse issued an error;

            argparse ?

> +
> +    - 3: -Werror is used, and one or more unfiltered parse warnings
> +         happened.
> +    """
>  
>      parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
>                                       description=DESC)
> @@ -323,16 +339,12 @@ def main():
>  
>      if args.werror:
>          print("%s warnings as errors" % error_count)    # pylint: disable=C0209
> -        sys.exit(error_count)
> +        sys.exit(WERROR_RETURN_CODE)
>  
>      if args.verbose:
>          print("%s errors" % error_count)                # pylint: disable=C0209
>  
> -    if args.none:
> -        sys.exit(0)
> -
> -    sys.exit(error_count)
> -
> +    sys.exit(0)
>  
>  # Call main method
>  if __name__ == "__main__":

-- 
~Randy


